import 'dart:convert';

import 'package:tdd_example/core/constants/constants.dart';
import 'package:tdd_example/core/error/exception.dart';
import 'package:tdd_example/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl(this.client);

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return WeatherModel.fromJson(json.decode(response.body));
  }
}
