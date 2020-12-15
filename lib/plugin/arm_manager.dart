

import 'package:flutter/services.dart';

class ArmManager {

  static final MethodChannel _channel=new MethodChannel('arm_plugin');

  static Future<String> start({Map map}) async{
    return await _channel.invokeMethod('start',map??{"disable-punctuation":true});
  }
  static Future<String> stop() async{
    return await _channel.invokeMethod('stop');
  }
  static Future<String> cancle() async{
    return await _channel.invokeMethod('cancle');
  }
  static Future<String> release() async{
    return await _channel.invokeMethod('release');
  }

}