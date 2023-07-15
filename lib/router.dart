import 'package:flutter/material.dart';
import 'package:weather_app/features/help_screen/help_screen.dart';
import 'package:weather_app/features/home_page_screen/home_page_screen.dart';

class Routes{
 static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/help-screen':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  const HelpScreen(),
      );
    case '/home-page-screen':
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePageScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,

  
        builder: (_) => const Scaffold(
          body: Text("The screen doesn't exists"),
        ),
      );
  }
}
}
