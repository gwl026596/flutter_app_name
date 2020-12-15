import 'package:flutter/material.dart';
import 'package:flutter_app_name/widget/webview.dart';

class My extends StatefulWidget{
  @override
  _MyState createState()=>_MyState();

}

class _MyState extends State<My>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        url: 'https://m.ctrip.com/webapp/myctrip/',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ));
  }

}