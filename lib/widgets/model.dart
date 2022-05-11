import 'package:simple_moment/simple_moment.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherInfo {
  
  String iconUrl(iconCode){
    return 'http://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  
  String parsedDate(String datetime){
  DateTime dt = DateTime.parse(datetime);
  final DateFormat formatter = DateFormat.yMMMMd('en_US');
  final String formatted = formatter.format(dt);
    return formatted;
  }
  String parsedDatewithTime(String datetime){
  DateTime dt = DateTime.parse(datetime);
  final DateFormat formatter = DateFormat.yMd().add_jm();
  final String formatted = formatter.format(dt);
    return formatted;
  }

}
