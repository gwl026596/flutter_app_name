
import 'package:flutter/material.dart';
import 'package:flutter_app_name/model/common_model.dart';
import 'package:flutter_app_name/widget/webview.dart';

class LocalNav extends StatelessWidget{
  final List<CommonModel> localNavList;

  const LocalNav({Key key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
     height: 70,
     decoration: BoxDecoration(
       borderRadius:BorderRadius.circular(12),
       color: Colors.white
     ),
     padding: EdgeInsets.symmetric(horizontal: 5),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: _addLocalnav(context),
     ),
   );
  }
 List<Widget> _addLocalnav(BuildContext context){
    List<Widget> list=[];
    localNavList.forEach((element) {
      list.add( Expanded( flex:1,child: _addLocalnavItem(context,element)));
    });
    return list;
  }

  Widget _addLocalnavItem(BuildContext context,CommonModel element) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WebView(
          url: element.url,
          title: element.title,
          statusBarColor: element.statusBarColor,
          hideAppBar: element.hideAppBar,
        )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(element.icon
            ,width:40,height: 40,),
          Text(element.title,style: TextStyle(fontSize: 13,color: Color(int.parse("0xFF222222"))),)
        ],
      ),
    );
  }
}