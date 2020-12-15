

import 'package:flutter_app_name/model/flight_model.dart';
import 'package:flutter_app_name/model/hotel_model.dart';
import 'package:flutter_app_name/model/travel_model.dart';

class GridNavModel{
  final HotelModel hotel;
  final FlightModel flight;
  final TravelModel travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String,dynamic> map){
    return GridNavModel(
        hotel:HotelModel.fromJson(map['hotel']),
      flight:FlightModel.fromJson(map['flight']),
      travel:TravelModel.fromJson(map['travel']),
    );
  }



}