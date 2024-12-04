import 'package:flutter/material.dart';
import 'package:smart_fit/body_measurement_screen.dart';
import 'package:smart_fit/height_input_screen.dart';
import 'package:smart_fit/result_screen.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HeightInputScreen.routeName,
      routes: {
        HeightInputScreen.routeName: ((context) => const HeightInputScreen()),
        BodyMeasurementScreen.routeName: (context) =>
            const BodyMeasurementScreen(),
      },
    );
  }
}
