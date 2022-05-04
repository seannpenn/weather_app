import 'package:simple_moment/simple_moment.dart';
import 'package:intl/intl.dart';

class WeatherInfo {
  late DateTime created;

  WeatherInfo({DateTime? created}) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }
  String iconUrl(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  String weatherBackground(String weatherCode){
    String path ='';
    switch(weatherCode){
      case 'Clouds':
        path = 'assets/images/cloudy.jpg';
        break;
      default:
        path = 'assets/images/white.jpg';
        break;
    }
      return path;
  }
  
  String parsedDate(String datetime){
    //  return Moment.fromDateTime(datetime).format('hh:mm a MMMM dd, yyyy ');
  // final DateTime now = DateTime.now();
  DateTime dt = DateTime.parse(datetime);
  final DateFormat formatter = DateFormat.yMMMMd('en_US');
  final String formatted = formatter.format(dt);
    return formatted;
  }

}
