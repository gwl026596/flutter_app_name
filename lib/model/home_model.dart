import 'package:flutter_app_name/model/common_model.dart';
import 'package:flutter_app_name/model/config_model.dart';
import 'package:flutter_app_name/model/gridNav_model.dart';
import 'package:flutter_app_name/model/salesBox_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> map) {
    var bannerList = map['bannerList'] as List;
    List<CommonModel> bannerMapList =
        bannerList.map((e) => CommonModel.fromJson(e)).toList();
    var localNavList = map['localNavList'] as List;
    List<CommonModel> localNavMapList =
        localNavList.map((e) => CommonModel.fromJson(e)).toList();
    var subNavList = map['subNavList'] as List;
    List<CommonModel> subNavMapList =
        subNavList.map((e) => CommonModel.fromJson(e)).toList();
    return HomeModel(
      config: ConfigModel.fromJson(map['config']),
      bannerList: bannerMapList,
      localNavList: localNavMapList,
      gridNav: GridNavModel.fromJson(map['gridNav']),
      subNavList: subNavMapList,
      salesBox: SalesBoxModel.fromJson(map['salesBox']),
    );
  }
}
