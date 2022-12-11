import 'package:flutter/material.dart';

import 'data_service.dart';
import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_response != null)
              Column(
                children: [
                  Image.network(
                    _response!.iconUrl,
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    _response!.weatherInfo.description,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text: 'Temp: ',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      TextSpan(
                          text: '${_response?.tempInfo.temperature}°C',
                          style: const TextStyle(fontSize: 30, height: 1.4)),
                    ]),
                  ),
                  Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text: 'Feels like: ', style: TextStyle(fontSize: 14)),
                      TextSpan(
                          text: '${_response?.feelslikeInfo.feels_like}°C',
                          style: const TextStyle(fontSize: 30, height: 1.4)),
                    ]),
                  ),
                  Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text: 'Pressure: ', style: TextStyle(fontSize: 14)),
                      TextSpan(
                          text: '${_response?.pressureInfo.pressure} hPa',
                          style: const TextStyle(fontSize: 30, height: 1.4)),
                    ]),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: _cityTextController,
                  decoration: const InputDecoration(labelText: 'City'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: _search, child: const Text('Get weather info'))
          ],
        ),
      ),
    ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
