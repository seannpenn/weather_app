import 'dart:convert';
// import 'package:weather/weather.dart';

import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/model.dart';

class DataService {
  WeatherFactory wf = WeatherFactory('2a69e303f550d4dafeff5ecc1e534042');

  Future<Weather> getWeather(String city) async {
    Weather data = await wf.currentWeatherByCityName(city);
    print(data);
    return data;
  }

  Future<List<Weather>> getWeekWeather(String city) async {
      List<Weather> forecast = await wf.fiveDayForecastByCityName(city);
    return forecast;
  }
}
