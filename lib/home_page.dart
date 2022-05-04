// import 'package:flutter/material.dart';
// import 'package:weather/weather.dart';
// import 'package:weather_app/service.dart';
// import 'package:weather_app/widgets/model.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _searchL();
//       _searchV();
//       _searchM();
//     });
//   }

//   final _dataService = DataService();

//   final String luzon = 'Manila';
//   final String visayas = 'Cebu';
//   final String mindanao = 'Davao';
//   Weather? _response;
//   Weather? _responseL;
//   Weather? _responseV;
//   Weather? _responseM;
//   final _weatherInfo = WeatherInfo();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.teal[300],
//         body: SafeArea(
//           child: Column(
//             children: [
//               ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [card(luzon), card(visayas), card(mindanao)],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   card(String island) {
//     switch (island) {
//       case 'Manila':
//         setState(() {
//           _response = _responseL;
//         });
//         break;
//       case 'Cebu':
//         setState(() {
//           _response = _responseV;
//         });
//         break;
//       case 'Davao':
//         setState(() {
//           _response = _responseM;
//         });
//         break;
//     }

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: Container(
//             width: 200,
//             height: 400,
//             decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text('${_response?.areaName}'),
//                   // Image.network(
//                   //   _weatherInfo.iconUrl('${_response?.weatherIcon}'),
//                   // ),
//                   Text(
//                     ' ${_response?.temperature!.celsius!.round()}°',
//                     style: const TextStyle(
//                         fontSize: 30, fontFamily: 'Roboto', color: Colors.black),
//                   ),
//                   Text('${_response?.weatherMain}',
//                       style: const TextStyle(
//                           fontSize: 15,
//                           fontFamily: 'Roboto',
//                           color: Colors.black)),
//                 ])),
//       ),
//     );
//   }

//   _searchL() async {
//     final response = await _dataService.getWeather(luzon);
//     setState(() => _responseL = response);
//   }

//   _searchV() async {
//     final response = await _dataService.getWeather(visayas);
//     setState(() => _responseV = response);
//   }

//   _searchM() async {
//     final response = await _dataService.getWeather(mindanao);
//     setState(() => _responseM = response);
//   }
// }
