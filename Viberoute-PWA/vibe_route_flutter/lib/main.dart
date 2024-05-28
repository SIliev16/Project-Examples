import 'package:flutter/material.dart';
import 'package:vibe_route_flutter/logo_animation.dart';
import 'package:vibe_route_flutter/user_preferences_screen.dart';
import 'package:vibe_route_flutter/dashboard_user.dart';
import 'package:vibe_route_flutter/ride_finished_screen.dart';
import 'package:vibe_route_flutter/ride_started_screen.dart';


Future main() async {
  runApp(const MyApp()); // Then run the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VibeRoute',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'RobotoMedium',
        scaffoldBackgroundColor: const Color(0xFFFEFFF6),
      ),
      home: const LogoAnimation(),
      routes: {
        '/dashboard': (context) => DashboardUser(),
        '/preferences': (context) => UserPreferencesScreen(),
        '/ride_finished': (context) => RideFinishedScreen(),
        '/ride_started': (context) => RideStartedScreen(),
      },
    );
  }
}

class LogoPage extends StatelessWidget {
  const LogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFFEFFF6),
      body: Center(
        child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            height: 200,
        ),
      ),
    );
  }
}
