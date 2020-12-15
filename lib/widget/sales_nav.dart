import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_name/model/common_model.dart';
import 'package:flutter_app_name/model/salesBox_model.dart';
import 'package:flutter_app_name/widget/webview.dart';

class SalesNav extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesNav({Key key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_addTitleNav(context), _addSubNav(context)],
      ),
    );
  }

  Widget _addTitleNav(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Image.network(
              salesBox?.icon ?? '',
              height: 30,
              width: 70,
            ),
          ),
          GestureDetector(
            onTap: () {
              _wrapMoreTap(context, salesBox?.moreUrl);
            },
            child: Container(
              padding: EdgeInsets.only(left: 8, top: 2, right: 8, bottom: 3),
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(colors: [
                    const Color(0xfffd4646),
                    const Color(0xffff6799)
                  ])),
              child: Text(
                '获得更多福利 >',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _addSubNav(BuildContext context) {
    List<Widget> list = [];
    if (salesBox == null) return Text('');
    list.add(_addImgItems(context, salesBox.bigCard1, salesBox.bigCard2, true));
    list.add(
        _addImgItems(context, salesBox.smallCard1, salesBox.smallCard2, false));
    list.add(
        _addImgItems(context, salesBox.smallCard3, salesBox.smallCard4, false));
    return Column(
      children: list,
    );
  }

  Widget _addImgItems(
      BuildContext context, CommonModel card1, CommonModel card2, bool big) {
    List<Widget> list = [];
    list.add(_addImgItem(context, card1, big, true));
    list.add(_addImgItem(context, card2, big, false));
    return Row(
      children: list,
    );
  }

  Widget _addImgItem(
      BuildContext context, CommonModel card, bool big, bool left) {
    return GestureDetector(
      onTap: () {
        _wrapTap(context, card);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              right: left
                  ? BorderSide(
                      width: 0.8, color: Color(int.parse('0xfff2f2f2')))
                  : BorderSide.none,
              bottom: BorderSide(
                  width: 0.8, color: Color(int.parse('0xfff2f2f2')))),
        ),
        child: Image.network(
          card.icon,
          width: MediaQuery.of(context).size.width / 2 - 10.6,
          height: big ? 120 : 80,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _wrapTap(BuildContext context, CommonModel item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebView(
              url: item.url,
              title: item.title,
              statusBarColor: item.statusBarColor,
              hideAppBar: item.hideAppBar,
            )));
  }
  _wrapMoreTap(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WebView(
              url: url,
              title: '更多福利',
              statusBarColor: null,
              hideAppBar: false,
            )));
  }
}
