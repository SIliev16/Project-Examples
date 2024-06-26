import 'package:flutter/material.dart';
import 'dashboar.dart';
import 'map.dart';
import 'calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel App',
      theme: ThemeData(
        primaryColor: Color(0xFF212029),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: Dashboard(),
    );
  }
}
