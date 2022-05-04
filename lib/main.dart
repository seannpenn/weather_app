import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/home_page.dart';
import 'package:weather_app/service.dart';
import 'package:weather_app/widgets/model.dart';
import 'package:weather_icons/weather_icons.dart';

void main() {
  runApp(const WeatherHomePage());
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     // _search();
  //     _searchForecast();
  //   });
  // }

  final _searchInput = TextEditingController();
  final _dataService = DataService();
  final _weatherInfo = WeatherInfo();

  Weather? _response;
  List<Weather>? _forecast;
  bool _validate = false;
  var error = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: const Text('Weather App'),
        //   centerTitle: true,
        //   backgroundColor: Colors.grey,
        // ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.cyan[600],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(children: [
              Column(
                children: [
                  searchBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(error),
                          if (_response == null)
                            Expanded(
                              child: Image.asset(
                                'assets/images/globe.png',
                                fit: BoxFit.contain,
                                color: Colors.white,
                                // color: const Color(0xff0d69ff).withOpacity(0.3),
                                // colorBlendMode: BlendMode.softLight,
                              ),
                            ),
                          const Text('Weatherman'),
                          if (_response != null) box(_response),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,

                  hintText: "Enter city..",
                  focusedBorder: const OutlineInputBorder(),
                  // enabledBorder: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
          Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black87, width: 1),
                borderRadius: BorderRadius.circular(6)
                // color: Colors.blueAccent,
                ),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                _search();
                _searchForecast();
                setState(() {
                  _validate = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  clearSearch() {
    _searchInput.clear();
    setState(() {});
  }

  Widget box(Weather? _data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        // height: 800,
        child: Center(
          child: Column(
            children: [
              Text('${_data?.areaName!.toUpperCase()}',
                  style: const TextStyle(
                      fontSize: 25, fontFamily: 'Roboto', color: Colors.white)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        // borderRadius: const BorderRadius.only(
                        //     bottomLeft: Radius.zero,
                        //     bottomRight: Radius.zero),
                        border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.black),
                        ),
                        // color: Colors.grey,
                      ),
                      child: Image.network(
                        _weatherInfo.iconUrl('${_data?.weatherIcon}'),
                        // scale: .6,
                      ),
                    ),
                  ],
                ),
              ),
              Text('${_data?.weatherDescription}',
                  style: const TextStyle(
                      fontSize: 15, fontFamily: 'Roboto', color: Colors.white)),
              Text(
                ' ${_data?.temperature!.celsius!.round()}°',
                style: const TextStyle(
                    fontSize: 75, fontFamily: 'Roboto', color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('Wind'),
                      Row(children: [
                        const Icon(
                          WeatherIcons.windy,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        Text(
                          '${_data?.windSpeed}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              color: Colors.white),
                        ),
                      ])
                    ],
                  ),
                  const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Humidity'),
                        Row(
                          children: [
                            const Icon(
                              WeatherIcons.humidity,

                              // Cupertino
                              color: Colors.white,
                              size: 24.0,
                            ),
                            Text(
                              '${_data?.humidity!.round()}%',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              weekForcast(),
            ],
          ),
        ),
      ),
    );
  }

  Widget weekForcast() {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20.0),
      // decoration: const BoxDecoration(color: Colors.black),
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (int x = 3; x < 39; x += 8) layout(_forecast, x),
        ],
      ),
    );
  }

  Widget layout(List<Weather>? _weekData, int x) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                _weatherInfo.iconUrl('${_weekData?[x].weatherIcon}'),
                scale: 1.8,
              ),
              // Text('${_weekData?[x].date}'),
              const Text('May 5'),
              Row(
                children: [
                  const Text(
                    'wind:',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: 15),
                  ),
                  // const Icon(
                  //         WeatherIcons.windy,
                  //         color: Colors.white,
                  //         size: 20.0,
                  //       ),
                  Text(
                    '  ${_weekData?[x].windSpeed}',
                    style: const TextStyle(
                        fontFamily: 'Robotolight', fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Text(
                    'humidity:',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: 15),
                  ),
                  // const Icon(
                  //             WeatherIcons.humidity,

                  //             // Cupertino
                  //             color: Colors.white,
                  //             size: 20.0,
                  //           ),
                  Text(
                    '  ${_weekData?[x].humidity}',
                    style: const TextStyle(
                        fontFamily: 'Robotolight', fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_searchInput.text);
    if (response.toJson()!.values.last == 200) {
      setState(() => _response = response);
    } else {
      setState(() {
        error = "City not found";
      });
    }
  }

  void _searchForecast() async {
    final response = await _dataService.getWeekWeather(_searchInput.text);

    setState(() => _forecast = response);
  }
}
