import 'dart:convert';

import 'package:flutter_app_name/model/home_model.dart';
import 'package:http/http.dart' as http;


class HomeNet{

  static Future<HomeModel> getHomeData() async {
    var response = await http.get('https://www.devio.org/io/flutter_app/json/home_page.json');
    if(response.statusCode==200){
      HomeModel homeModel=  HomeModel.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));
      return homeModel;
    }else{
    throw Exception('Failed to load home_page.json');
    }

  }
}