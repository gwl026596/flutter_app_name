

import 'package:flutter_app_name/model/common_model.dart';

class SalesBoxModel{
  final String icon;
  final String moreUrl;
  final CommonModel bigCard1;
  final CommonModel bigCard2;
  final CommonModel smallCard1;
  final CommonModel smallCard2;
  final CommonModel smallCard3;
  final CommonModel smallCard4;

  SalesBoxModel({this.icon, this.moreUrl, this.bigCard1, this.bigCard2, this.smallCard1, this.smallCard2, this.smallCard3, this.smallCard4});

  factory SalesBoxModel.fromJson(Map<String,dynamic> map){
    return SalesBoxModel(
      icon:map['icon'],
      moreUrl:map['moreUrl'],
      bigCard1:CommonModel.fromJson(map['bigCard1']),
      bigCard2:CommonModel.fromJson(map['bigCard2']),
      smallCard1:CommonModel.fromJson(map['smallCard1']),
      smallCard2:CommonModel.fromJson(map['smallCard2']),
      smallCard3:CommonModel.fromJson(map['smallCard3']),
      smallCard4:CommonModel.fromJson(map['smallCard4']),
    );
  }

}