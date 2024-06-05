import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_example/core/constants/constants.dart';
import 'package:tdd_example/core/error/exception.dart';
import 'package:tdd_example/data/data_sources/remote_data_source.dart';
import 'package:tdd_example/data/models/weather_model.dart';
import '../../helpers/json_helper.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(mockHttpClient);
  });

  const testCityName = 'New York';
  const String dummyWeatherResponsePath = 'helpers/dummy_data/dummy_weather_response.json';

  final request = Uri.parse(Urls.currentWeatherByName(testCityName));

  test('should return weather model when the response code is 200', () async {
    //arrange
    when(
      mockHttpClient.get(request),
    ).thenAnswer(
      (_) async => http.Response(readJson(dummyWeatherResponsePath), 200),
    );

    //act
    try {
      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, isA<WeatherModel>());
      expect(result.cityName, isNotNull);
      expect(result.main, isNotNull);
      expect(result.description, isNotNull);
      expect(result.iconCode, isNotNull);
      expect(result.temperature, isNotNull);
      expect(result.pressure, isNotNull);
      expect(result.humidity, isNotNull);
    } catch (e) {
      fail('Test failed with exception: $e');
    }
  });

  test(
    'should throw a server exception when the response code is 404 or other',
    () async {
      //arrange
      when(
        mockHttpClient.get(request),
      ).thenAnswer((_) async => http.Response('Not found', 404));

      //act
      final result = weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, throwsA(isA<ServerException>()));
    },
  );
}
