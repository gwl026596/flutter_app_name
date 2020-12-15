import 'dart:convert';

import 'package:flutter_app_name/model/search_model.dart';
import 'package:flutter_app_name/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const TRAVEL_TAB_URL='https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/travel_page.json';
class TravelTabNet{

  static Future<TravelTabModel> getSearhData() async {
    var response = await http.get(TRAVEL_TAB_URL);
    if(response.statusCode==200){
      TravelTabModel travelTabModel=  TravelTabModel.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));
      return travelTabModel;
    }else{
    throw Exception('Failed to load home_page.json');
    }

  }
}