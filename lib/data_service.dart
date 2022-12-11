import 'dart:convert';

import 'package:wheather_app/models.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse>getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': 'd83670ec98df5c5f6c905876491ed0ed',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
