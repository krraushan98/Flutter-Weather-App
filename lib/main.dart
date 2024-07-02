import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatheapp/Services/weatherData.dart';
import 'package:weatheapp/screens/home.dart';
import 'package:weatheapp/screens/weatherDetails.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => weatherData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
       routes: {
        '/weatherDetails': (context) => const WeatherDetails(),
      },
    );
  }
}
