import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/model/weather.dart';

import '../data_response.dart';

class WeatherRepo {
  final _dio = Dio();

  SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences != null) {
      return _preferences!;
    } else {
      _preferences = await SharedPreferences.getInstance();
      return _preferences!;
    }
  }

//to know the old data
  Map<String, WeatherModel> _oldData = {};

  initalize() async {
    final sharedPref = await preferences;
    final stringVaue = sharedPref.getString("savedcity") ??
        ""; //to convert this string to olddata type do these things below:
    if (stringVaue != "" || stringVaue != "{}") {
      final tempData = jsonDecode(stringVaue); //1. decode converts to dynamic

      final value = Map<String, dynamic>.from(
          tempData); //2. after dynamic can convert to any type

      //3. now need to convert Map<String, dynamic> to  Map<String, Map<String,dynamic>> ,after doing step 2 i.e convert to map with some type then only we can map like step 3 to that type given avbove.
      final result = value.map((key, value) => MapEntry(
          key,
          Map<String, dynamic>.from(
              value))); //key is already string coz mathi ko value lai map gareko = Map<String, dynamic>just need to convert dynamic to Map<String, dynamic> so do it using MapEntry
      //coz we need to put value of sharedpref i.e previously saved to now in olddata which is in type Map<String, WeatherModel>
      _oldData = result.map((key, value) => MapEntry(
          key, WeatherModel.fromSharedPref(value))); //for old date from model
      //last ma value haleko chai coz value cha WetaherModel ko type ma
      //yesare old data ko type ma result aisakyo tei rakheko
    }
  }

  Future<DataResponse<WeatherModel>> getWeather(String city) async {
    final WeatherModel? oldWeather = _oldData[city]; //city is key
    if (oldWeather != null) {
      if (oldWeather.savedDate != null) {
        if (DateTime.now().difference(oldWeather.savedDate!).inSeconds <= 60) {
          return DataResponse.success(oldWeather);
        }
      }
    }
    final _response = await _dio.get(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2");

    print(_response.statusCode);
    print(_response.data["main"]);

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      final _weather = _response.data["main"];

      WeatherModel model =
          WeatherModel.fromJsson(_weather); //for new date from model
      _oldData[city] = model; //city is key and key is Weahermodel type
      //to convert olddata type to string coz need to save string in sharedpref
      final Map<
          String,
          Map<String,
              dynamic>> _temp = _oldData.map((key, value) => MapEntry(
          key,
          value
              .toJson())); //done coz can be encoded only if it is map/json but not model.
      String data = json.encode(_temp); //encode converts to string
      final sharedPref = await preferences;

      await sharedPref.setString("savedcity", data);

      ///for new date from model

      return DataResponse.success(model);
    } else {
      throw Exception();
    }
  }
}
