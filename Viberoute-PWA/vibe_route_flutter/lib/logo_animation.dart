import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_route_flutter/dashboard_user.dart';
import 'package:vibe_route_flutter/user_preferences_screen.dart';

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({super.key});

  @override
  _LogoAnimationState createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _animateLogo();
  }

  _animateLogo() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      opacityLevel = 1.0;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      opacityLevel = 0.0;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCompletedQuestionnaire = prefs.getBool('hasCompletedQuestionnaire') ?? false;
    if (hasCompletedQuestionnaire) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardUser()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserPreferencesScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFFF6),
      body: Center(
        child: AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 1),
          child: Image.asset('assets/logo.png', fit: BoxFit.contain, height: 200),
        ),
      ),
    );
  }
}
