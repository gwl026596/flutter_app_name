

import 'package:flutter_app_name/model/common_model.dart';

class FlightModel{
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  FlightModel({this.startColor, this.endColor, this.mainItem, this.item1, this.item2, this.item3, this.item4});
  factory FlightModel.fromJson(Map<String,dynamic> map){
    return FlightModel(
      startColor:map['startColor'],
      endColor:map['endColor'],
      mainItem:CommonModel.fromJson(map['mainItem']),
      item1:CommonModel.fromJson(map['item1']),
      item2:CommonModel.fromJson(map['item2']),
      item3:CommonModel.fromJson(map['item3']),
      item4:CommonModel.fromJson(map['item4']),
    );
  }

}