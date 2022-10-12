import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/weather_repo.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.weatherRepo}) : super(WeatherIsNotSearched());
  WeatherRepo weatherRepo;
  fetchWeather({required city}) async {
    emit(WeatherIsLoading());
    try {
      //gives weather of the city given
      final weather =
          await weatherRepo.getWeather(city); //city name goes to the api url
      
      emit(WeatherIsLoaded(weather.data));
    } catch (_) {
      emit(WeatherIsNotLoaded());
    }
  }

  resetWeather() async {
    emit(WeatherIsNotSearched());
  }

  
}
