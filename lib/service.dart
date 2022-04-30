import 'dart:convert';
import 'package:weather/weather.dart';

import 'package:http/http.dart' as http;

class DataService {
  Future<Weather> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    // final queryParameters = {
    //   'q': city,
    //   'appid': '944c45c731b2223fa6dfc656b823ce9b',
    //   'units': 'imperial'
    // };

    // final uri = Uri.https(
    //     'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    // final response = await http.get(uri);

    WeatherFactory wf = WeatherFactory('944c45c731b2223fa6dfc656b823ce9b');

    // final response = 
    Weather json = await wf.currentWeatherByCityName(city);

    // print(response.body);
    // final json = jsonDecode(response.body);
    // return WeatherResponse.fromJson(json);
    return json;
  }
}