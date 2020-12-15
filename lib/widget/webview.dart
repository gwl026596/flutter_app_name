import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const ALL_URL=['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];
class WebView extends StatefulWidget {
  final String url;
  final String title;
  final bool hideAppBar;
  final String statusBarColor;
  final bool backForbid;

  const WebView(
      {Key key,
      this.url,
      this.title,
      this.hideAppBar,
      this.statusBarColor,
      this.backForbid=false})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  FlutterWebviewPlugin _flutterWebviewPlugin= FlutterWebviewPlugin();
  StreamSubscription<String> urlChanged;
  StreamSubscription<WebViewStateChanged> stateChanged;
  StreamSubscription<WebViewHttpError> httpError;
  @override
  void initState() {
    super.initState();
     _flutterWebviewPlugin.close();
    urlChanged= _flutterWebviewPlugin.onUrlChanged.listen((event) {

    });
    stateChanged =_flutterWebviewPlugin.onStateChanged.listen((event) {
      switch(event.type){
        case WebViewState.startLoad:
         if(_isToMain(event.url)&&!widget.backForbid){
            Navigator.pop(context);
         }else{
           _flutterWebviewPlugin.launch(event.url);
         }
          break;
          default:
            break;
      }
    }) ;
    httpError= _flutterWebviewPlugin.onHttpError.listen((event) {

    });
  }
  @override
  void dispose() {
    super.dispose();
    _flutterWebviewPlugin.dispose();
    urlChanged.cancel();
    stateChanged.cancel();
    httpError.cancel();
  }
  @override
  Widget build(BuildContext context) {
    String backgroudColor = widget.statusBarColor ?? "FFFFFF";
    return Scaffold(
      body: Column(
        children: [
          _appBar(context,Color(int.parse('0xFF' + backgroudColor)),
              backgroudColor == "FFFFFF" ? Colors.black : Colors.white),
          Expanded(
              flex: 1,
              child: WebviewScaffold(
                url: widget.url,
                withLocalStorage: true,
                withZoom: true,
                hidden: true,
                initialChild: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      '正在加载中..',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  _appBar(BuildContext context,Color statusBarColor, Color backBtnColor) {
    double statusBarColorHeight=MediaQuery.of(context).padding.top;
    if (widget.hideAppBar ?? false) {
      return Container(
        color: statusBarColor,
        height: statusBarColorHeight,
      );
    }

    return Container(
      color: statusBarColor,
      padding: EdgeInsets.only(top:(statusBarColorHeight+10),bottom: 10),
      child:  Stack(
        children: [
          Container(
            color: statusBarColor,
            child: FractionallySizedBox(
              widthFactor: 1,
              child:  Center(
                  child: Text(
                    widget.title ?? '',
                    style: TextStyle(color: backBtnColor, fontSize: 20),
                  ),

              ),
            )
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.close,
                color: backBtnColor,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isToMain(String url) {
   return ALL_URL.any((element) => url.endsWith(element));
  }
}
