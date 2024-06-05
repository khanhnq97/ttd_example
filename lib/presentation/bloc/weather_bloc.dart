import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdd_example/domain/usecases/get_current_weather.dart';
import 'package:tdd_example/presentation/bloc/weather_event.dart';
import 'package:tdd_example/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());
      final result = await _getCurrentWeatherUseCase.execute(event.cityName);
      result.fold(
        (failure) {
          emit(WeatherLoadFailure(failure.message));
        },
        (data) {
          emit(WeatherLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
