import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_example/core/error/failure.dart';
import 'package:tdd_example/domain/entities/weather.dart';
import 'package:tdd_example/presentation/bloc/weather_bloc.dart';
import 'package:tdd_example/presentation/bloc/weather_event.dart';
import 'package:tdd_example/presentation/bloc/weather_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const cityName = 'New York';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(cityName)).thenAnswer(
        (_) async => const Right(testWeatherEntity),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeatherEntity),
    ],
  );

  blocTest(
    'should emit [WeatherLoading, WeatherFailure] when data gotten unsuccessful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(cityName)).thenAnswer(
        (_) async => const Left(ServerFailure('Server failure')),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure('Server failure'),
    ],
  );
}
