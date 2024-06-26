import 'package:dio/dio.dart';
import 'package:weather_app/core/params/forecast_params.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_app/features/feature_weather/data/models/current_city_model.dart';
import 'package:weather_app/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:weather_app/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:weather_app/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:weather_app/features/feature_weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImp extends WeatherRepository {
  ApiProvider apiProvider;
  WeatherRepositoryImp(this.apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    try {
      Response response = await apiProvider.callCurentWeather(cityName);
      if (response.statusCode == 200) {
        return DataSuccess(CurrentCityModel.fromJson(response.data));
      } else {
        return const DataFailed('Someting Went Wrong.try again...');
      }
    } catch (e) {
      return const DataFailed('please chek your connection...');
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params) async {
    try {
      Response response = await apiProvider.sendRequest7DaysForcast(params);
      if (response.statusCode == 200) {
        ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return const DataFailed('Someting Went Wrong.try again...');
      }
    } catch (e) {
      print(e.toString());
      return const DataFailed('please chek your connection...');
    }
  }
}
