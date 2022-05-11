import 'dart:convert';
import 'dart:io';
// import 'package:weather/weather.dart';

import 'package:flutter/cupertino.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/model.dart';

class DataService {
  var errorMessage = '';
  WeatherFactory wf = WeatherFactory('2a69e303f550d4dafeff5ecc1e534042');

  // Future<Weather> getWeather(String city) async {
  //   try {
  //     Weather data = await wf.currentWeatherByCityName(city);
  //     print(data);
  //     return data;
  //   } catch(e){
  //     errorMessage = 'City not found';
  //     throw(errorMessage);
  //   }
  // }
  Future<Weather> getWeather(String city) async {
    
      Weather data = await wf.currentWeatherByCityName(city);
      
      return data;
  }

  String get weatherError {
    return errorMessage;
  }

  // Future<List<Weather>?> getWeekWeather(String city) async {
  //   try {
  //     List<Weather> forecast = await wf.fiveDayForecastByCityName(city);
  //     return forecast;
  //   } on Exception catch(e){
  //     print(e);
  //   }
  // }
  Future<List<Weather>?> getWeekWeather(String city) async {
    
      List<Weather> forecast = await wf.fiveDayForecastByCityName(city);
      return forecast;
  }
}
