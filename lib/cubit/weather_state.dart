part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherIsNotSearched extends WeatherState {

}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final weather;
  WeatherIsLoaded(this.weather);

  // WeatherModel get getWeather=>_weather;
  @override
  List<Object?> get props => [weather];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherIsSame extends WeatherState{
  final sameWeather;
  WeatherIsSame(this.sameWeather);
}