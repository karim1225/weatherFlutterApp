import 'package:dio/dio.dart';
import 'package:weather_app/core/utils/constants.dart';

class ApiProvider{
  final _dio = Dio();
  var apiKey = Constants.apiKey;

  Future<dynamic>callCurentWeather(cityName) async {
    var response = _dio.get(
      '${Constants.baseUrl}/data/2.5/weather',
      queryParameters: {
          'q' : cityName,
          'appid' : apiKey,
          'units' : 'metric'
      }
    );
    return response;
  }
}