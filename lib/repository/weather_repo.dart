import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/model/weather.dart';

import '../data_response.dart';

class WeatherRepo {
  final _dio = Dio();
  Map<String, dynamic> _old = {};
  init() {
    getdata();
  }

  SharedPreferences? _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences != null) {
      return _preferences!;
    } else {
      _preferences = await SharedPreferences.getInstance();
      return _preferences!;
    }
  }

  // savedata() async {
  //   final _sharedPref = await preferences;

  //   await _sharedPref.setString("savedcity", jsonEncode(_oldData));
  //   var data = _sharedPref.getString("savedcity");
  // }

  Map<String, WeatherModel> _oldData = {};

  getdata() async {
    final _sharedPref = await preferences;
    // String tempData =
    //     (_sharedPref.getString("savedcity") ?? "");

    final tempData = json.decode(_sharedPref.getString("savedcity") ?? "");
    final value = Map<String, dynamic>.from(tempData);
    final result = value
        .map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
    _oldData = result
        .map((key, value) => MapEntry(key, WeatherModel.fromJsson(value)));

    // var data = _sharedPref.getString("savedcity") ?? "";
    // _oldData = jsonDecode(data);
    // var d=

    return _oldData;
  }

  Future<DataResponse<WeatherModel>> getWeather(String city) async {
    final _sharedPref = await preferences;
    final _response = await _dio.get(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2");

    print(_response.statusCode);
    print(_response.data["main"]);

    if (_response.statusCode == 200 || _response.statusCode == 201) {
      final _weather = _response.data["main"];
      // print(_weather);
      WeatherModel model = WeatherModel.fromJsson(_weather);

     
      // // DateTime dt1 = DateTime.parse();

      // String value = jsonEncode(model.toJson());
      // // _old[city]=value;
      // _oldData[city] = model;

      // savedata();

      // print(_oldData);
      // _oldData[city] = model;
      // final newdate = model.savedDate;
      // print(newdate?.minute);
      // final olddate = _oldData[city]?.savedDate;
      // print(olddate?.minute);

      final Map<String, Map<String, dynamic>> _temp =
          _oldData.map((key, value) => MapEntry(key, value.toJson()));
      String data = json.encode(_temp);

      _sharedPref.setString("savedcity", data);

      return DataResponse.success(model);
      
    } else {
      throw Exception();
    }
  }
}
