import 'package:mockito/annotations.dart';
import 'package:tdd_example/data/data_sources/remote_data_source.dart';
import 'package:tdd_example/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_example/domain/usecases/get_current_weather.dart';

@GenerateMocks([
  WeatherRepository,
  WeatherRemoteDataSource,
  GetCurrentWeatherUseCase,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
