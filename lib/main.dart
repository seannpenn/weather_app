import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/service.dart';

void main() {
  runApp(const WeatherHomePage());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WeatherHomePage(),
//     );
//   }
// }

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final _searchInput = TextEditingController();
  final _dataService = DataService();

  Weather? _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter city..",
                              // focusedBorder: OutlineInputBorder(),
                              // enabledBorder: const OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20.0, 0, 5, 0),
                              suffix: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                                onPressed: () {
                                  clearSearch();
                                },
                              ),
                            ),
                            controller: _searchInput,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _search();
                          
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    // width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cloudy.jpg'),
                        fit: BoxFit.cover,
                      ),
                      // shape: BoxShape.circle,
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (_response != null)
                               Text('${_response!.areaName}'),
                              //  Text('${_response!.temperature}',style: const TextStyle(fontSize: 14),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
    
              ],
            ),
          ),
        ),
      ),
    );
  }

  clearSearch() {
    _searchInput.clear();
    setState(() {});
  }

  box(String city) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue), //BoxDecoration
        child: Text(city),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_searchInput.text);
    setState(() => _response = response);
  }

  // Widget weatherBox(WeatherInfo? _weather) {
  //   return Column(
  //     children: <Widget>[
  //       Text("${_weather?.cityName}"),
  //       Text("${_weather?.temp}"),
  //     ],
  //   );
  // }
}
