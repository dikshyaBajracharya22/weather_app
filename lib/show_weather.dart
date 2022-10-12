import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';

import 'model/weather.dart';

class ShowWeather extends StatelessWidget {
  WeatherModel
      weather; //from front now this weather has the weather of city inserted
  final city;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherCubit>(context);

    return Container(
        padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          children: <Widget>[
            Text(
              city,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              weather.getTemp.round().toString() + "C",
              style: const TextStyle(color: Colors.white70, fontSize: 50),
            ),
            const Text(
              "Temprature",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      weather.getMinTemp.round().toString() + "C",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    const Text(
                      "Min Temprature",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      weather.getMaxTemp.round().toString() + "C",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    const Text(
                      "Max Temprature",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: <Widget>[
                Text(
                  weather.humidity.round().toString() + "%",
                  style: const TextStyle(color: Colors.white70, fontSize: 30),
                ),
                const Text(
                  "Humidity",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  weatherBloc.resetWeather();
                },
                color: Colors.lightBlue,
                child: const Text(
                  "Search",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            )
          ],
        ));
  }
}
