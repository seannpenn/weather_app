import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/weather.dart';
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
  final FocusNode _fn = FocusNode();

  Weather? _response;
  List<Weather>? _forecast;
  bool _validate = false;
  var errorMessage = '';

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
            child: Column(
              children: [
                searchBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Text(error),
                          if (_response == null) const Text('Weatherman'),
                          if (_response == null)
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 50),
                              child: Image.asset(
                                'assets/images/globe.png',
                                fit: BoxFit.contain,
                                color: Colors.white,
                                // color: const Color(0xff0d69ff).withOpacity(0.3),
                                // colorBlendMode: BlendMode.softLight,
                              ),
                            ),
                          if (_response != null) box(_response),
                        ],
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
                  // errorStyle: const TextStyle(),

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
                      _fn.unfocus();
                      clearSearch();
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                controller: _searchInput,
                focusNode: _fn,
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
                _fn.unfocus();
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
                padding: const EdgeInsets.all(12.0),
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
                        _weatherInfo
                            .iconUrl('${_data?.weatherIcon.toString()}'),
                        // scale: .6,
                      ),
                    ),
                  ],
                ),
              ),
              Text('${_data?.weatherDescription}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      letterSpacing: 2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' ${_data?.temperature!.celsius!.round()}°',
                    style: const TextStyle(
                        fontSize: 75,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('feels like'),
                      Text(
                        ' ${_data?.tempFeelsLike}°',
                        style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
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
                              fontSize: 25,
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
                                  fontSize: 25,
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
              const Text('Forecast',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              if (_data != null) weekForcast(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text('Additional Information'),
                  Icon(Icons.arrow_downward_outlined),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        WeatherIcons.thermometer,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      const Text('Min Temp: '),
                      Text('${_data?.tempMin}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        WeatherIcons.thermometer,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      const Text('Max Temp: '),
                      Text('${_data?.tempMax}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.metronome,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      const Text('Pressure: '),
                      Text('${_data?.pressure} hPa',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.location,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      const Text('Longitude: '),
                      Text('${_data?.longitude}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.location_solid,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      const Text('Latitude: '),
                      Text('${_data?.latitude}',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget weekForcast() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      // decoration: const BoxDecoration(color: Colors.black),

      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (int x = 5; x < 39; x += 8)
            if (_forecast != null) layout(_forecast, x),
        ],
      ),
    );
  }

  layout(List<Weather>? _weekData, x) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.network(
                _weatherInfo.iconUrl(_weekData?[x].weatherIcon.toString()),
                scale: 1.8,
              ),
              Text(_weatherInfo.parsedDate('${_weekData?[x].date}')),
              Text('${_weekData?[x].weatherDescription}',
                  style:
                      const TextStyle(color: Colors.white, letterSpacing: 2)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Wind:',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  // const Icon(
                  //         WeatherIcons.windy,
                  //         color: Colors.white,
                  //         size: 20.0,
                  //       ),
                  Text(
                    '  ${_weekData?[x].windSpeed}',
                    style: const TextStyle(
                        fontFamily: 'Robotolight',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Humidity:',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '  ${_weekData?[x].humidity}%',
                    style: const TextStyle(
                        fontFamily: 'Robotolight',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Pressure:',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '  ${_weekData?[x].pressure} hPa',
                    style: const TextStyle(
                        fontFamily: 'Robotolight',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
    try {
      final response = await _dataService.getWeather(_searchInput.text);
      print(_dataService.weatherError);
      setState(() {
        _response = response;
        errorMessage = _dataService.weatherError;
      });
    } catch (error) {
      setState(() {
        errorMessage = _dataService.weatherError;
      });
    }
  }

  void _searchForecast() async {
    final response = await _dataService.getWeekWeather(_searchInput.text);
    setState(() => _forecast = response);
  }
}
