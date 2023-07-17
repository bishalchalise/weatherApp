import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/models/weather.dart';

class WeatherService {
  final String apiKey = '4279f608255e44f5b43140325231707';
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<Weather> getCurrentWeatherByLocation(String location) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$location'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return Weather.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<Weather> getCurrentWeatherByCoordinates(double latitude, double longitude) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$latitude,$longitude'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return Weather.fromJson(jsonBody);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
