import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _searchInput = TextEditingController();
  final FocusNode _fn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 0, 20.0, 0),
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
                          validator: (value){
                            if (value == null || value.isEmpty) {
                                return 'City name invalid';
                              }
                              return null;
                          },
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        clearSearch();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  clearSearch() {
    _searchInput.clear();
    setState(() {});
  }
}
