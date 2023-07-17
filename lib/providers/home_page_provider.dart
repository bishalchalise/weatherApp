import 'package:flutter/material.dart';

class HomePageScreenProvider extends ChangeNotifier{
    String _location = '';
  String get location => _location;

  void setLocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }
}