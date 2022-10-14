import 'package:intl/intl.dart';


class WeatherModel {
  final double temp;
  final double feels_like;
  final int pressure;
  final int humidity;
  final double temp_max;
  final double temp_min;
  final DateTime? savedDate;


  double get getTemp => temp - 272.5; //calvins to centigrate converted
  double get getMaxTemp => temp_max - 272.5;
  double get getMinTemp => temp_min - 272.5;

  WeatherModel(
      {required this.temp,
      required this.feels_like,
      required this.pressure,
      required this.humidity,
      required this.temp_max,
      required this.temp_min,
      required this.savedDate
      });
//convert json map to Weather Model
//for getting new data
  factory WeatherModel.fromJsson(Map<String, dynamic> json) {//which format the api is in Map<String, dynamic>
    return WeatherModel(
        temp: json["temp"],
        feels_like: json["feels_like"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        temp_max: json["temp_max"],
        savedDate: DateTime.now(),
        temp_min: json["temp_min"],);
  }

//for getting old data
factory WeatherModel.fromSharedPref(Map<String, dynamic> json) {//which format the api is in Map<String, dynamic>
    return WeatherModel(
        temp: json["temp"],
        feels_like: json["feels_like"],
        pressure: json["pressure"],
        humidity: json["humidity"],
        temp_max: json["temp_max"],
        savedDate: DateTime.tryParse(json["savedDate"] ?? ""),
        temp_min: json["temp_min"],);
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");


   Map<String, dynamic> toJson() {
    final Map<String,dynamic> _temp = {
        "temp": temp,
        "feels_like": feels_like,
        "pressure": pressure,
        "humidity": humidity,
        "temp_max": temp_max,
        "temp_min": temp_min,
      };

if(savedDate != null){
  _temp["savedDate"] = savedDate!.toString();
}

return _temp;
   }
}
