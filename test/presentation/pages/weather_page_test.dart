import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_example/presentation/bloc/weather_bloc.dart';
import 'package:tdd_example/presentation/bloc/weather_event.dart';
import 'package:tdd_example/presentation/bloc/weather_state.dart';
import 'package:tdd_example/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState> implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (_) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'text filed should trigger state to change from empty to loading',
    (widgetTester) async {
      // arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();
      expect(find.text('New York'), findsOneWidget);
    },
  );

  testWidgets(
    ' should show text "loading..." ',
    (widgetTester) async {
      // arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

      // assert
      var loadingText = find.byKey(const Key('loading-text'));
      expect(loadingText, findsOneWidget);
    },
  );
}
