import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_example/data/models/weather_model.dart';
import 'package:tdd_example/domain/entities/weather.dart';

import '../../helpers/json_helper.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  test('should be a subclass of weather entity', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    //assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    //act
    final result = testWeatherModel.toJson();

    final expectJsonMap = {
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01n',
        },
      ],
      'main': {
        'temp': 292.87,
        'pressure': 1012,
        'humidity': 70,
      },
      'name': 'New York',
    };

    expect(result, equals(expectJsonMap));
  });
}
