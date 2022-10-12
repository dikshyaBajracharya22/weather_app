import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/repository/weather_repo.dart';


class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  const MultiRepositoryWrapper({ Key? key , required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
      create: (context) => WeatherRepo(),
        ),
        
      ], child: child,
    );
  }
}