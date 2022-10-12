import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/repository/weather_repo.dart';
import 'package:weather_app/show_weather.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {
      WeatherRepo weatherRepo=WeatherRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  final weather= weatherRepo.init();
  
  return weather;
  }
  late SharedPreferences prefs;
  TextEditingController cityController = TextEditingController();
  String cityname = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 100),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            height: 200,
            width: 200,
            child: Image.asset(
              "assets/image.jpeg",
              fit: BoxFit.contain,
            ),
          )),
          BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
            if (state is WeatherIsNotSearched) {
              return Container(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Search Weather",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70),
                    ),
                    const Text(
                      "Instanly",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w200,
                          color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue, style: BorderStyle.solid)),
                        hintText: "City Name",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () {
                          context
                              .read<WeatherCubit>()
                              .fetchWeather(city: cityController.text);
                        },
                        color: Colors.lightBlue,
                        child: const Text(
                          "Search",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    ),
                    Text(
                      cityname,
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    )
                  ],
                ),
              );
            } else if (state is WeatherIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherIsLoaded) {
              return ShowWeather(state.weather, cityController.text);
            }
            return Center(
                child: const Text(
              "Could not find the city",
              style: TextStyle(fontSize: 25, color: Colors.red),
            ));
          })
        ],
      ),
    );
  }
}
