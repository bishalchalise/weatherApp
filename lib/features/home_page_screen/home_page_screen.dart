import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/common/custom_button.dart';
import 'package:weather_app/common/custom_text_field.dart';
import 'package:weather_app/features/weather/weather.dart';
import 'package:weather_app/providers/home_page_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/home-page-screen';
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController _locationController = TextEditingController();
  late SharedPreferences _prefs;
  bool isLocationEmpty = true;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _locationController.addListener(_onLocationChanged); // Add the listener
    _initSharedPreferences();
  }

  void _onLocationChanged() {
    setState(() {
      isLocationEmpty = _locationController.text.isEmpty;
    });
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    String? savedLocation = _prefs.getString('location');
    if (savedLocation != null) {
      _locationController.text = savedLocation;
    }
  }

  void _saveLocation() {
    final String location = _locationController.text;
    _prefs.setString('location', location);
    if (location.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please enter a location.'),
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
    } else {
      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      weatherProvider.fetchCurrentWeatherByLocation(location).then((_) {
        final currentWeather = weatherProvider.currentWeather;
        if (currentWeather == null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Failed to fetch weather data.'),
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
        } else {
          Navigator.pushNamed(context, LiveWeather.routeName);
        }
      });
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<HomePageScreenProvider>(
                    builder: (context, value, child) {
                  return CustomTextField(
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.blueGrey,
                    ),
                    controller: _locationController,
                    hintText: 'Enter Location',
                    // initialValue: value.location,
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: _saveLocation,
                  text: isLocationEmpty ? 'Save' : 'Update',
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
