import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';



class WeatherProvider with ChangeNotifier {
  Weather? _currentWeather;
  late WeatherService _weatherService;

  WeatherProvider() {
    _weatherService = WeatherService();
  }

  Future<void> fetchCurrentWeatherByLocation(String location) async {
    try {
      final weather = await _weatherService.getCurrentWeatherByLocation(location);
      _currentWeather = weather;
      notifyListeners();
    } catch (error) {
    
      print('Error fetching weather data: $error');
    }
  }

  Future<void> fetchCurrentWeatherByCoordinates(double latitude, double longitude) async {
    try {
      final weather = await _weatherService.getCurrentWeatherByCoordinates(latitude, longitude);
      _currentWeather = weather;
      notifyListeners();
    } catch (error) {
    
      print('Error fetching weather data: $error');
    }
  }

  Weather? get currentWeather => _currentWeather;
}
