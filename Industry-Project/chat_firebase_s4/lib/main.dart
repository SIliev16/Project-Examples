import 'package:camera/camera.dart';
import 'package:chat_firebase_s4/auth/auth_gate.dart';
import 'package:chat_firebase_s4/auth/auth_service.dart';
import 'package:chat_firebase_s4/firebase_options.dart';
import 'progress.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  cameras = await availableCameras();
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        home: HomeScreen(cameras),
      // home: AuthGate(),
    );
  }
}
