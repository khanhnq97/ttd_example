import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_example/presentation/bloc/weather_bloc.dart';
import 'package:tdd_example/presentation/bloc/weather_event.dart';
import 'package:tdd_example/presentation/bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter city name',
              ),
              onChanged: (query) {
                bloc.add(OnCityChanged(query));
              },
            ),
            const SizedBox(height: 30),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.result.toString()),
                    ],
                  );
                }
                if (state is WeatherLoading) {
                  return const Text(
                    'Loading...',
                    key: Key('loading-text'),
                  );
                }
                if (state is WeatherLoadFailure) {
                  return Text(state.message);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
