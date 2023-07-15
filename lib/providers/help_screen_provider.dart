import 'package:flutter/material.dart';
import 'package:weather_app/features/home_page_screen/home_page_screen.dart';

class HelpScreenProvider with ChangeNotifier {
  bool _skipButtonClicked = false;

  bool get skipButtonClicked => _skipButtonClicked;

  void redirectToHomepage(BuildContext context) {
    _skipButtonClicked = true;
    notifyListeners();
    Navigator.pushNamed(context, HomePageScreen.routeName);
  }
}
