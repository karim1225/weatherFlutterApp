import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/presentation/ui/main_wrapper.dart';
import 'package:weather_app/features/feature_weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/locator.dart';

void main() async {
  // init locator
  await setup();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<WeatherBloc>()),
      ],
      child: MainWrapper(),
    ),
  ));
}
