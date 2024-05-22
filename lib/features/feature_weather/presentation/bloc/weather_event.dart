part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class LoadCwEvent extends WeatherEvent {
  final String cityName;
  LoadCwEvent(this.cityName);
}
