import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/core/params/forecast_params.dart';
import 'package:weather_app/core/utils/constants.dart';

class ApiProvider {
  final _dio = Dio();
  var apiKey = Constants.apiKey;

  Future<dynamic> callCurentWeather(cityName) async {
    var response = await _dio.get('${Constants.baseUrl}/data/2.5/weather',
        queryParameters: {'q': cityName, 'appid': apiKey, 'units': 'metric'});
    return response;
  }

  /// 7 days forecast api
  Future<dynamic> sendRequest7DaysForcast(ForecastParams params) async {
    var response = await _dio
        .get("${Constants.baseUrl}/data/2.5/onecall", queryParameters: {
      'lat': params.lat,
      'lon': params.lon,
      'exclude': 'minutely,hourly',
      'appid': apiKey,
      'units': 'metric'
    });
    return response;
  }
}
