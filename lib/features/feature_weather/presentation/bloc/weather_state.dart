part of 'weather_bloc.dart';

// ignore: must_be_immutable
class WeatherState extends Equatable {
  CwStatus cwStatus;
  FwStatus fwStatus;

  WeatherState({required this.cwStatus, required this.fwStatus});

  WeatherState copyWith({CwStatus? newCwStatus, FwStatus? newFwStatus}) {
    return WeatherState(
        cwStatus: newCwStatus ?? cwStatus, fwStatus: newFwStatus ?? fwStatus);
  }

  @override
  List<Object?> get props => [cwStatus, fwStatus];
}
