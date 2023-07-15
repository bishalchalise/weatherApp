import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/home-page-screen';
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
    
      body:  Center(
        child: Text("This is HomePageScreen Screen"),
      ),
    );
  }
}
