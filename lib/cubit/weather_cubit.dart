import 'package:bloc/bloc.dart';
import 'package:cubit_sample/model/weather.dart';
import 'package:cubit_sample/model/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather: weather));
    } on NetworkException {
      emit(const WeatherError(
          message: 'Could not fetch weather. Check device connectivity'));
    }
  }
}
