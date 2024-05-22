import 'package:get_it/get_it.dart';
import 'package:weather_app/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_app/features/feature_weather/data/repository/weather_repository_imp.dart';
import 'package:weather_app/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:weather_app/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/weather_bloc.dart';

GetIt locator = GetIt.instance;

setup() {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  //repositories
  locator.registerSingleton<WeatherRepository>(WeatherRepositoryImp(locator()));

  //use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(locator()));

 //bloc
  locator.registerSingleton<WeatherBloc>(WeatherBloc(locator()));
}
