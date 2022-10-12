import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/repository/weather_repo.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(
            weatherRepo: RepositoryProvider.of<WeatherRepo>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
