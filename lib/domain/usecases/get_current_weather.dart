import 'package:dartz/dartz.dart';
import 'package:tdd_example/core/error/failure.dart';
import 'package:tdd_example/domain/entities/weather.dart';
import 'package:tdd_example/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  GetCurrentWeatherUseCase(this._weatherRepository);

  final WeatherRepository _weatherRepository;

  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return _weatherRepository.getCurrentWeather(cityName);
  }
}
