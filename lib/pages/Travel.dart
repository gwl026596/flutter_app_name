import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_name/model/travel_tab_model.dart';
import 'package:flutter_app_name/net/travel_net.dart';
import 'package:flutter_app_name/net/travel_tab_net.dart';
import 'package:flutter_app_name/pages/travel_item_page.dart';
import 'package:flutter_app_name/widget/loading_widget.dart';

class Travel extends StatefulWidget{
  @override
  _TravelState createState()=>_TravelState();

}

class _TravelState extends State<Travel> with TickerProviderStateMixin{
  TravelTabModel tabModel;
  TabController _tabController;
  List<Tabs> tabsList=[];

 @override
  void initState() {
    _tabController=TabController(length: 0,vsync: this);
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
            child: Column(
              children: [
                _tab_view(),
                _tab_bar_view()
              ],
            ),

        ),

    );
  }

  void _loadData() async{
    TravelTabModel travelTabModel= await TravelTabNet.getSearhData();
    _tabController=TabController(length: travelTabModel.tabs.length,vsync: this);
    setState(() {
      tabModel=travelTabModel;
      tabsList=travelTabModel.tabs;

    });
    //TravelTabNet.getSearhData().then((value) => setData(value)).catchError((onError) => print(onError.toString()));
  }

  _tab_view() {
   return Container(
     padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
     decoration: BoxDecoration(
       color: Colors.white
     ),
     child: TabBar(
       controller: _tabController,
       tabs:  tabsList.map<Tab>((e) => Tab(text: e.labelName,)).toList(),
       labelColor: Colors.black,
       labelPadding: EdgeInsets.fromLTRB(10, 0, 20, 5),
       isScrollable: true,
       indicator: UnderlineTabIndicator(
         borderSide: BorderSide(color: Color(int.parse('0xff2fcfbb')),width: 3),
         insets: EdgeInsets.only(bottom: 5)
       ),
     ),
   );
  }

  setData( TravelTabModel travelTabModel) {
    _tabController=TabController(length: travelTabModel.tabs.length,vsync: this);
    setState(() {
      tabModel=travelTabModel;
      tabsList=travelTabModel.tabs;
    });

  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _tab_bar_view() {
   return Flexible(child: Container(
     child:TabBarView(
       controller: _tabController,
       children:tabsList.map((e) => TravelPageItem(groupChannelCode: e.groupChannelCode,type: e.type,)).toList() ,
     ) ,
   ));
  }
}