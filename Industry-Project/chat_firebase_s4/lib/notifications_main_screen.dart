import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'map_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('launch_background');
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const NotificationScreen(title: 'Settings'),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.title});

  final String title;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _locationMessage = "";
  int _selectedLocation = 0;

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  void _navigateToMapScreen() async {
    _requestPermissions();
    try {
      Position position = await _determinePosition();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MapScreen(initialLocation: LatLng(position.latitude, position.longitude)),
      ));
    } catch (e) {
      print('Error obtaining location: $e');
      Fluttertoast.showToast(
        msg: "Error obtaining location: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _requestPermissions() async {
    var status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      // Location permission granted
      var backgroundStatus = await Permission.locationAlways.request();
      if (backgroundStatus == PermissionStatus.granted) {
      } else {
        print("Background location permission denied.");
      }
    } else {
      print("Location permission denied.");
    }
  }



  @override
  Widget build(BuildContext context) {
    List<String> arrivingTexts = [
      'Arriving: Current location',
      'Arriving: Dimitar\'s Home',
      'Arriving at Dimitar\'s Workplace',
      'Getting Out of Car',
      'Arriving at Gym'
    ];

    List<IconData> locationIcons = [
      Icons.my_location,
      Icons.home,
      Icons.work,
      Icons.directions_car,
      Icons.fitness_center
    ];

    List<String> locationTexts = [
      'Current',
      'Home',
      'Work',
      'Getting Out',
      'Gym'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF15B0A9),
        foregroundColor: Color(0xFFFFFFFF),
        title: Text('Reminders'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Reminders will help you stay on top of your recovery!',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Please allow notifications if you want to be reminded to do your exercises, when you get home.',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 16.0),
              Card(
                color: Color(0xFF606DB2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Your Home Address', style: TextStyle(color: Colors.white)),
                        subtitle: Text('Eckartseweg Zuid 314, 5623 PC', style: TextStyle(color: Colors.white70)),
                      ),
                      ListTile(
                        title: Text('Your Work Address', style: TextStyle(color: Colors.white)),
                        subtitle: Text('Achtseweg Zuid 151C, 5651 GW', style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                color: Color(0xFF606DB2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    children: [
                      Text(
                        'Reminder location',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 16.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ToggleButtons(
                          borderRadius: BorderRadius.circular(30),
                          selectedBorderColor: Colors.transparent,
                          fillColor: Colors.transparent,
                          renderBorder: false,
                          children: List.generate(locationIcons.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                children: [
                                  Icon(
                                    locationIcons[index],
                                    color: _selectedLocation == index ? Color(0xFF15B0A9) : Colors.white,
                                    size: 30.0,
                                  ),
                                  Text(
                                    locationTexts[index],
                                    style: TextStyle(
                                      color: _selectedLocation == index ? Color(0xFF15B0A9) : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          onPressed: (int index) {
                            setState(() {
                              _selectedLocation = index;
                            });
                          },
                          isSelected: List.generate(5, (index) => index == _selectedLocation),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        arrivingTexts[_selectedLocation],
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              // Add more UI elements if needed
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToMapScreen,
        tooltip: 'Select Location on Map',
        backgroundColor: Color(0xFF15B0A9),
        child: const Icon(Icons.map),
      ),
    );
  }
}