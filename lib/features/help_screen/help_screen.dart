import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/help_screen_provider.dart';

class HelpScreen extends StatefulWidget {
  static const routeName = '/help-screen';
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 5), () {
      Provider.of<HelpScreenProvider>(context, listen: false)
          .redirectToHomepage(context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff7c4dff),
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                'assets/image/image-removebg.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'We show weather for you',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _timer?.cancel();
                        Provider.of<HelpScreenProvider>(context, listen: false)
                            .redirectToHomepage(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xff00d659),
                        ),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
