import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_name/model/search_model.dart';
import 'package:flutter_app_name/net/search_net.dart';
import 'package:flutter_app_name/pages/speak_page.dart';
import 'package:flutter_app_name/widget/search_bar.dart';
import 'package:flutter_app_name/widget/webview.dart';

const URL =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=';

class Search extends StatefulWidget {
  final String  keyWordStr;

  const Search({Key key, this.keyWordStr}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchModel searchModel;
   String defalutTexStr;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(
              hideLeftBtn: true,
              hint: '请输入搜索内容',
              defalutTex: defalutTexStr,
              rightBtnClick: () {},
              speakBtnClick: () async {
                var result =await  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Speak()));
                if(result!=null&&result.length>0){
                  setState(() {
                    defalutTexStr=result;
                  });
                  _changeText(result);
                }
              },
              changed: _changeText),
          Expanded(
              flex: 1,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: searchModel?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) =>
                      _addItems(context, index),
                ),
              ))
        ],
      ),
    );
  }

  void _changeText(String value) {
    if (value.length <= 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    SearhNet.getSearhData(URL + value, value)
        .then((value) => setData(value))
        .catchError((onError) => print(onError.toString()));
  }

  setData(SearchModel value) {
    setState(() {
      searchModel = value;
    });
  }

  _addItems(BuildContext context, int index) {
    if (searchModel == null ||
        searchModel.data == null ||
        searchModel.data.length <= 0) return Text('');

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebView(
                  url: searchModel.data.elementAt(index).url,
                  title: searchModel.data.elementAt(index).word.length > 8
                      ? searchModel.data.elementAt(index).word.substring(0, 8)
                      : searchModel.data.elementAt(index).word,
                  hideAppBar: false,
                )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 0.8, color: Color(int.parse("0xfff0f0f0"))))),
        child: Row(
          children: [
            Container(
              child: _addImage(searchModel, index),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  child: RichText(
                    text: TextSpan(
                        children: _addKeyWordContent(searchModel, index)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  padding: EdgeInsets.only(top: 8),
                  child: ((searchModel?.data?.elementAt(index)?.price??'').length>0||(searchModel?.data?.elementAt(index)?.star??'').length>0)?RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: (searchModel?.data?.elementAt(index)?.price ??
                                  "") +
                              " ",
                          style: TextStyle(color: Colors.orange, fontSize: 16)),
                      TextSpan(
                          text:
                              (searchModel?.data?.elementAt(index)?.star ?? ""),
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ]),
                  ):null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _addKeyWordContent(SearchModel searchModel, int index) {
    print('hh ${searchModel.keyWord}');
    List<String> keyWordList =
        searchModel.data.elementAt(index).word.split(searchModel.keyWord);

    List<TextSpan> spanList = [];
    TextStyle nomalStyle = TextStyle(fontSize: 16, color: Colors.black);
    TextStyle keyWordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    TextStyle greyStyle = TextStyle(fontSize: 16, color: Colors.grey);
    for (int i = 0; i < keyWordList.length; i++) {
      spanList.add(TextSpan(text: keyWordList[i], style: nomalStyle));
      if (i != keyWordList.length - 1) {
        spanList.add(TextSpan(text: searchModel.keyWord, style: keyWordStyle));
      }
    }
    spanList.add(TextSpan(
        text: (" " +
            (searchModel?.data?.elementAt(index)?.districtname ?? "") +
            (searchModel?.data?.elementAt(index)?.zonename ?? "")),
        style: greyStyle));
    return spanList;
  }

  _addImage(SearchModel searchModel, int index) {
    List<String> imgaeList = [
      'channelgroup',
      'channelgs',
      'channelplane',
      'channeltrain',
      'cruise',
      'district',
      'food',
      'hotel',
      'huodong',
      'shop',
      'sight',
      'ticket',
      'travelgroup'
    ];
    String image = 'assets/images/type_travelgroup.png';
    if (imgaeList.indexOf(searchModel.data.elementAt(index).type) > -1) {
      image =
          'assets/images/type_${searchModel.data.elementAt(index).type}.png';
    }
    return Image.asset(
      image,
      height: 30,
      width: 30,
    );
  }
}
