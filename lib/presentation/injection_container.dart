import 'package:get_it/get_it.dart';
import 'package:tdd_example/data/data_sources/remote_data_source.dart';
import 'package:tdd_example/data/repositories/weather_repository_impl.dart';
import 'package:tdd_example/domain/repositories/weather_repository.dart';
import 'package:tdd_example/domain/usecases/get_current_weather.dart';
import 'package:tdd_example/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
