import 'package:cubit_sample/cubit/weather_cubit.dart';
import 'package:cubit_sample/model/weather.dart';
import 'package:cubit_sample/model/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is WeatherInitial) {
              return buildInitialInput(context);
            } else if (state is WeatherLoading) {
              return buildLoading();
            } else if (state is WeatherLoaded) {
              return buildColumnWithData(context, state.weather);
            } else {
              return buildInitialInput(context);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          weather.cityName,
        ),
        Text(
          weather.temperatureCelsius.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        buildTextFieldInput(context),
      ],
    );
  }

  TextField buildTextFieldInput(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (cityName) {
        final weatherCubit = BlocProvider.of<WeatherCubit>(context);
        weatherCubit.getWeather(cityName);
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your city',
        suffixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitialInput(BuildContext context) {
    return Center(
      child: buildTextFieldInput(context),
    );
  }
}
