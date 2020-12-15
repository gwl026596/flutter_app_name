import 'package:flutter/material.dart';
import 'package:flutter_app_name/pages/Home.dart';
import 'package:flutter_app_name/pages/My.dart';
import 'package:flutter_app_name/pages/Search.dart';
import 'package:flutter_app_name/pages/Travel.dart';

class NavigationBar extends StatefulWidget{
  @override
  _NavigationBarState createState()=>_NavigationBarState();

}

class _NavigationBarState extends State<NavigationBar>{
  int _selectedIndex=0;
  final Color _colorGrey=Colors.grey;
  final Color _colorBlue=Colors.blue;
  final PageController pageController=PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Home(),
          Search(),
          Travel(),
          My(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed ,
        currentIndex:_selectedIndex,
          onTap: (int index) {
            pageController.jumpToPage(index);
            setState(() {
              _selectedIndex = index;
            });
          },
        selectedItemColor: _colorBlue,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,color: _colorGrey),label: '首页',activeIcon:Icon(Icons.home,color:_colorBlue )),
            BottomNavigationBarItem(icon: Icon(Icons.search,color: _colorGrey),label: '索索',activeIcon:Icon(Icons.search,color:_colorBlue )),
            BottomNavigationBarItem(icon: Icon(Icons.photo_camera,color: _colorGrey),label: '旅拍',activeIcon:Icon(Icons.photo_camera,color:_colorBlue )),
            BottomNavigationBarItem(icon: Icon(Icons.person_pin,color: _colorGrey),label: '我的',activeIcon:Icon(Icons.person_pin,color:_colorBlue ))
          ],
      ),
    );
  }

}