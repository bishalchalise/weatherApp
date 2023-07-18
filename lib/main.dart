import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/help_screen_provider.dart';
import 'package:weather_app/providers/home_page_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

import 'package:weather_app/router.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HelpScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        )
      ],
      child: const MaterialApp(
        title: 'Weather App',
        onGenerateRoute: Routes.generateRoute,
        initialRoute: '/help-screen',
      ),
    );
  }
}
