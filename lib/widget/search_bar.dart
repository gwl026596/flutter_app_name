import 'package:flutter/material.dart';

enum SearchBarType { NOMAL, HOME, HOMELIGHT }

class SearchBar extends StatefulWidget {
  final bool enableSearch; //禁止搜索
  final bool hideLeftBtn; //隐藏左边按钮
  final String hint; //输入框提示文字
  final String defalutTex; //默认文本
  final SearchBarType seachType; //搜索类型
  final void Function() leftBtnClick; //左边按钮点击回调
  final void Function() rightBtnClick; //又边按钮点击回调
  final void Function() speakBtnClick; //录音按钮点击回调
  final void Function() inputBoxClick; //输入框按钮点击回调
  final ValueChanged<String> changed;

  const SearchBar(
      {Key key,
      this.enableSearch = false,
      this.hideLeftBtn,
      this.hint,
      this.defalutTex,
      this.seachType = SearchBarType.NOMAL,
      this.leftBtnClick,
      this.rightBtnClick,
      this.speakBtnClick,
      this.inputBoxClick,
      this.changed})
      : super(key: key); //内容改变回调

  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  final textEditingController = TextEditingController();
  bool showClear = false;
  @override
  void initState() {
    super.initState();
    if (widget.defalutTex != null) {
      textEditingController.text = widget.defalutTex;
    }
  }
  @override
  void didUpdateWidget(covariant SearchBar oldWidget) {
    if (widget.defalutTex != null&&oldWidget.defalutTex!=widget.defalutTex) {
      textEditingController.text = widget.defalutTex;
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
          color: widget.seachType == SearchBarType.NOMAL
              ? Colors.white
              : Colors.transparent),
      child: widget.seachType == SearchBarType.NOMAL
          ? _searchInput()
          : _homeInput(),
    );
  }

  _homeInput() {}

  _searchInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
      child: Row(
        children: [
          _wrapOnTap(
              Container(
                child: widget.hideLeftBtn
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.grey,
                      ),
              ),
              widget.leftBtnClick),
          Expanded(
              flex: 1,
              child: Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.only(left: 5, top: 2, right: 5, bottom: 2),
                decoration: BoxDecoration(
                    color: Color(int.parse('0xfff2f2f2')),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: widget.hint,
                            border: InputBorder.none,
                            hintStyle:TextStyle(fontSize: 16, color: Colors.black),
                            contentPadding: EdgeInsets.only(left: 4,top: 0, right: 4,bottom: 10)),
                        controller: textEditingController,
                        onChanged: _changeStr,
                      ),
                    ),
                    showClear
                        ? _wrapOnTap(
                            Container(
                              child: Icon(Icons.clear,
                                  size: 20, color: Colors.grey),
                            ), () {
                            textEditingController.clear();
                            _changeStr('');
                            setState(() {
                              showClear = false;
                            });
                          })
                        : _wrapOnTap(
                            Container(
                              child:
                                  Icon(Icons.mic, size: 20, color: Colors.blue),
                            ),
                            widget.speakBtnClick)
                  ],
                ),
              )),
          _wrapOnTap(
              Container(
                child: Text(
                  '搜索',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
              widget.rightBtnClick)
        ],
      ),
    );
  }

  _wrapOnTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }

  void _changeStr(String value) {
    if (value.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.changed != null) {
      widget.changed(value);
    }
  }
}
