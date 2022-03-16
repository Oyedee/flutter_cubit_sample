import 'package:cubit_sample/cubit/weather_cubit.dart';
import 'package:cubit_sample/model/weather_repository.dart';
import 'package:cubit_sample/screens/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => WeatherCubit(FakeWeatherRepo()),
          child: const WeatherPage(title: 'Cubit Demo Home Page')),
    );
  }
}
