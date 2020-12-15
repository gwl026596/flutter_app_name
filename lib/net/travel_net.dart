import 'dart:convert';

import 'package:flutter_app_name/model/search_model.dart';
import 'package:flutter_app_name/model/travel_item_model.dart';
import 'package:flutter_app_name/model/travel_tab_model.dart';
import 'package:flutter_app_name/util/log_utils.dart';
import 'package:http/http.dart' as http;

const TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031010211161114530&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

var params = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": null,
  "lat": 34.2317081,
  "lon": 108.928918,
  "locatedDistrictId": 7,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {
    "cid": "09031010211161114530",
    "ctok": "",
    "cver": "1.0",
    "lang": "01",
    "sid": "8888",
    "syscode": "09",
    "auth": null,
    "extension": [
      {"name": "protocal", "value": "https"}
    ]
  },
  "contentType": "json"
};
class TravelNet{

  static Future<TraveItemlModel> getTravelData(int pageIndex,String groupChannelCode ,int type) async {
    Map paramData=params["pagePara"];
    paramData["pageIndex"]=pageIndex;
    params["groupChannelCode"]=groupChannelCode;
    params["type"]=type;
    var response = await http.post(TRAVEL_URL,body: jsonEncode(params));
    if(response.statusCode==200){
      TraveItemlModel traveItemlModel=  TraveItemlModel.fromJson(json.decode(Utf8Decoder().convert(response.bodyBytes)));
      return traveItemlModel;
    }else{
    throw Exception('Failed to load home_page.json');
    }

  }
}