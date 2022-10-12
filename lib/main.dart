import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/repository/weather_repo.dart';
import 'package:weather_app/search.dart';
import 'package:weather_app/wrapper/multi_repository.dart';
import 'package:weather_app/wrapper/multibloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryWrapper(
      child: MultiBlocWrapper(
        child: MaterialApp(
          title: "Flutter Demo",
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[900],
            body: BlocProvider(
              create: (BuildContext context) => WeatherCubit(
                  weatherRepo: RepositoryProvider.of<WeatherRepo>(context)),
              child: SearchPage(),
            ),
          ),
        ),
      ),
    );
  }
}
