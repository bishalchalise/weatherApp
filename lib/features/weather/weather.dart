import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class LiveWeather extends StatefulWidget {
  static const routeName = '/live-weather';
  @override
  _LiveWeatherState createState() => _LiveWeatherState();
}

class _LiveWeatherState extends State<LiveWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             
             const SizedBox(height: 16.0),
              Consumer<WeatherProvider>(
                builder: (context, weatherProvider, _) {
                  final currentWeather = weatherProvider.currentWeather;
                  if (currentWeather != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: ${currentWeather.location.name}'),
                        Text('Temperature: ${currentWeather.current.tempC}°C'),
                        Text(
                            'Condition: ${currentWeather.current.condition.text}'),
                        // Add more weather data fields as needed
                      ],
                    );
                  } else {
                    return const Text('No weather data available');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
