import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/help_screen_provider.dart';

import 'package:weather_app/router.dart';

void main() {
  
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create:(context) => HelpScreenProvider(),
      child: MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: Routes.generateRoute,
          initialRoute: '/help-screen',
          ),
    );
  }
}
