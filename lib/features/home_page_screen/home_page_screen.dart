// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/common/custom_button.dart';
import 'package:weather_app/common/custom_text_field.dart';
import 'package:weather_app/features/help_screen/help_screen.dart';
import 'package:weather_app/features/temperature_view/temperature_view.dart';
import 'package:weather_app/providers/home_page_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/home-page-screen';

  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late TextEditingController _locationController;
  late SharedPreferences _prefs;
  bool isLocationEmpty = true;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _locationController.addListener(_onLocationChanged);
    _initSharedPreferences();
  }

  void _onLocationChanged() {
    setState(() {
      isLocationEmpty = _locationController.text.isEmpty;
    });
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    final savedLocation = _prefs.getString('location');
    if (savedLocation != null) {
      _locationController.text = savedLocation;
    }
  }

  Future<void> _saveLocation() async {
    final location = _locationController.text;

    if (location.isNotEmpty) {
      _prefs.setString('location', location);

      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      await weatherProvider.fetchCurrentWeatherByLocation(location);

      await Navigator.pushNamed(context, TemperatureView.routeName);
    } else {
      final permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.deniedForever) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Location Permission'),
              content: const Text(
                  'Please grant location permission in settings to fetch weather data automatically.',),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (permission == LocationPermission.denied) {
        final requestedPermission = await Geolocator.requestPermission();

        if (requestedPermission == LocationPermission.denied) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Location Permission'),
                content: const Text(
                    'Please grant location permission to fetch weather data automatically.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        try {
          final position = await Geolocator.getCurrentPosition();
          final latitude = position.latitude;
          final longitude = position.longitude;

          final weatherProvider =
              Provider.of<WeatherProvider>(context, listen: false);
          await weatherProvider.fetchCurrentWeatherByCoordinates(
              latitude, longitude);

          await Navigator.pushNamed(context, TemperatureView.routeName);
        } catch (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Location Error'),
                content: const Text(
                    'Failed to retrieve current location. Please check your device settings.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageScreenProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff7c4dff),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, HelpScreen.routeName);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: Container(
          color: const Color(0xff7c4dff),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _locationController,
                    builder: (context, value, child) {
                      return CustomTextField(
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xff7c4dff),
                        ),
                        controller: _locationController,
                        hintText: 'Enter Location',
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: _saveLocation,
                    text: isLocationEmpty ? 'Save' : 'Update',
                    color: const Color(0xff00d659),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
