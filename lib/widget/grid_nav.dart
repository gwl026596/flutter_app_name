import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_name/model/common_model.dart';
import 'package:flutter_app_name/model/flight_model.dart';
import 'package:flutter_app_name/model/gridNav_model.dart';
import 'package:flutter_app_name/model/hotel_model.dart';
import 'package:flutter_app_name/model/travel_model.dart';
import 'package:flutter_app_name/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNav;

  const GridNav({Key key, this.gridNav}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      color: Color(int.parse('0xFFfafafc')),
      child: Column(children: _addGridNavs(context)),
    );
  }

  List<Widget> _addGridNavs(BuildContext context) {
    List<Widget> list = [];
    if (gridNav == null) {
      return list;
    }
    if (gridNav.hotel != null) {
      list.add(_addGridNavItem(context, gridNav.hotel));
    }
    if (gridNav.flight != null) {
      list.add(_addGridNavFlightItem(context, gridNav.flight));
    }
    if (gridNav.travel != null) {
      list.add(_addGridNavTravelItem(context, gridNav.travel));
    }
    return list;
  }

  Widget _addGridNavItem(BuildContext context, HotelModel hotel) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(int.parse('0xFF' + hotel.startColor)),
        Color(int.parse('0xFF' + hotel.endColor))
      ])),
      child: Row(
        children: _addItem(context, hotel),
      ),
    );
  }

  Widget _addGridNavFlightItem(BuildContext context, FlightModel hotel) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(int.parse('0xFF' + hotel.startColor)),
        Color(int.parse('0xFF' + hotel.endColor))
      ])),
      child: Row(
        children: _addFlightItem(context, hotel),
      ),
    );
  }

  Widget _addGridNavTravelItem(BuildContext context, TravelModel hotel) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(int.parse('0xFF' + hotel.startColor)),
        Color(int.parse('0xFF' + hotel.endColor))
      ])),
      child: Row(
        children: _addTravelItem(context, hotel),
      ),
    );
  }

  _addItem(BuildContext context, HotelModel hotel) {
    List<Widget> list = [];
    list.add(_mainItem(context, hotel.mainItem));
    list.add(_item(context, hotel.item1, hotel.item2));
    list.add(_item(context, hotel.item3, hotel.item4));
    List<Widget> outPutList = [];
    list.forEach((element) {
      outPutList.add(Expanded(
        flex: 1,
        child: element,
      ));
    });
    return outPutList;
  }

  _addFlightItem(BuildContext context, FlightModel hotel) {
    List<Widget> list = [];
    list.add(_mainItem(context, hotel.mainItem));
    list.add(_item(context, hotel.item1, hotel.item2));
    list.add(_item(context, hotel.item3, hotel.item4));
    List<Widget> outPutList = [];
    list.forEach((element) {
      outPutList.add(Expanded(
        flex: 1,
        child: element,
      ));
    });
    return outPutList;
  }

  _addTravelItem(BuildContext context, TravelModel hotel) {
    List<Widget> list = [];
    list.add(_mainItem(context, hotel.mainItem));
    list.add(_item(context, hotel.item1, hotel.item2));
    list.add(_item(context, hotel.item3, hotel.item4));
    List<Widget> outPutList = [];
    list.forEach((element) {
      outPutList.add(Expanded(
        flex: 1,
        child: element,
      ));
    });
    return outPutList;
  }

  Widget _mainItem(BuildContext context, CommonModel mainItem) {
    return GestureDetector(
        onTap: () {
          _wrapTap(context, mainItem);
        },
        child: Stack(
          children: [
            Image.network(
              mainItem.icon,
              width: 120,
              height: 80,
              alignment: Alignment.bottomCenter,
            ),
            Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  mainItem.title,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ))
          ],
        ));
  }

  Widget _item(BuildContext context, CommonModel item1, CommonModel item2) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              _wrapTap(context, item1);
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            width: 0.7, color: Color(int.parse('0xFFfafafc'))),
                        bottom: BorderSide(
                            width: 0.7,
                            color: Color(int.parse('0xFFfafafc'))))),
                child: Center(
                  child: Text(
                    item1.title,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              _wrapTap(context, item2);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                    width: 0.7, color: Color(int.parse('0xFFfafafc'))),
              )),
              child: Center(
                child: Text(
                  item2.title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
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
