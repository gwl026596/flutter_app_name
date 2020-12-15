import 'package:flutter/material.dart';
import 'package:flutter_app_name/model/common_model.dart';
import 'package:flutter_app_name/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int oneLineNum = (subNavList.length / 2 + 0.5).toInt();
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _addLocalnav(context,subNavList.sublist(0, oneLineNum)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _addLocalnav(context,
                    subNavList.sublist(oneLineNum, subNavList.length)),
              ),
            ),
          ],
        ));
  }

  List<Widget> _addLocalnav(BuildContext context,List<CommonModel> listNav) {
    List<Widget> list = [];
    listNav.forEach((element) {
      list.add(Expanded(flex: 1, child: _addLocalnavItem(context,element)));
    });
    return list;
  }

  Widget _addLocalnavItem(BuildContext context,CommonModel element) {
    return GestureDetector(
      onTap: () {
        _wrapTap(context, element);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            element.icon,
            width: 30,
            height: 30,
          ),
          Text(
            element.title,
            style:
                TextStyle(fontSize: 10, color: Color(int.parse("0xFF222222"))),
          )
        ],
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
}
