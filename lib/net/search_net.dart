import 'dart:convert';

import 'package:flutter_app_name/model/search_model.dart';
import 'package:http/http.dart' as http;


class SearhNet{

  static Future<SearchModel> getSearhData(String url,String keyword) async {
    var response = await http.get(url);
    if(response.statusCode==200){
      SearchModel searchModel=  SearchModel.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));
      searchModel.keyWord=keyword;
      return searchModel;
    }else{
    throw Exception('Failed to load home_page.json');
    }

  }
}