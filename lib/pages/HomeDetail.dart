import 'package:flutter/material.dart';

class HomeDetail extends StatefulWidget{
  @override
  _HomeDetailState createState()=>_HomeDetailState();

}

class _HomeDetailState extends State<HomeDetail>{

  final PageController pageController=PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading:IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title:Text('详情页'),
         centerTitle: true,
      ),
      body:Center(
        child: Text('首页详情页'),
      ),
    );
  }

}