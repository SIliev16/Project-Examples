import 'dart:async';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:geolocator/geolocator.dart';
import 'notifications_main_screen.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLocation;
  const MapScreen({super.key, required this.initialLocation});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng? _selectedLocation;
  double _radius = 1000;
  Stream<GeofenceStatus>? _geofenceBroadcastStream;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  Marker? _userLocationMarker;
  Circle? _userLocationCircle;
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _initializeGeofenceStream();
  }

  void _initializeGeofenceStream() {
    var geofenceStream = EasyGeofencing.getGeofenceStream();
    if (geofenceStream != null) {
      _geofenceBroadcastStream = geofenceStream.asBroadcastStream();
    } else {
      print("Geofence stream is null");
      // Handle null case appropriately
    }
  }

  void _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled and if permissions are granted
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    setState(() {
      _selectedLocation = currentLocation;
      if (_isMapReady) {
        _updateMapLocation(currentLocation);
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _isMapReady = true;
      if (_selectedLocation != null) {
        // Update the map view only if the location has been obtained before map initialization.
        _updateMapLocation(_selectedLocation!);
      }
    });
  }

  void _updateMapLocation(LatLng location) {
    // Create a Marker for the selected location
    _userLocationMarker = Marker(
      markerId: MarkerId('selectedLocation'),
      position: location,
      infoWindow: InfoWindow(title: 'Your Location'),
    );

    // Create a Circle to show the geofence radius around the selected location
    _userLocationCircle = Circle(
      circleId: CircleId('geofenceRadius'),
      center: location,
      radius: _radius,
      fillColor: Colors.blue.withOpacity(0.3),
      strokeColor: Colors.blue,
      strokeWidth: 1,
    );

    mapController.animateCamera(CameraUpdate.newLatLng(location));
  }


  void _onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _userLocationMarker = Marker(
        markerId: const MarkerId('userLocation'),
        position: _selectedLocation!,
        infoWindow: const InfoWindow(title: 'Geofence Center'),
      );

      _userLocationCircle = Circle(
        circleId: const CircleId('userLocationRadius'),
        center: _selectedLocation!,
        radius: _radius,
        fillColor: Colors.blue.withOpacity(0.3),
        strokeColor: Colors.blue,
        strokeWidth: 1,
      );
    });
  }

  @override
  void dispose() {
    geofenceStatusStream?.cancel();
    super.dispose();
  }

  void _setGeofence() async {
    String latitudeString = _selectedLocation!.latitude.toString();
    String longitudeString = _selectedLocation!.longitude.toString();
    String radiusString = _radius.toString();

    EasyGeofencing.startGeofenceService(
      pointedLatitude: latitudeString,
      pointedLongitude: longitudeString,
      radiusMeter: radiusString,
      eventPeriodInSeconds: 5,
    );
    if (_geofenceBroadcastStream != null) {
      geofenceStatusStream?.cancel(); // Cancel any previous subscription
      geofenceStatusStream = _geofenceBroadcastStream?.listen(
            (GeofenceStatus status) async {
          if (status == GeofenceStatus.enter) {
            Fluttertoast.showToast(
              msg: "You've entered the geofenced area. Don't forget to do your exercises!",
              toastLength: Toast.LENGTH_LONG,
            );
            try {
              await _showNotification();
            } catch (e) {
              print("Failed to show notification: $e");
            }
          } else if (status == GeofenceStatus.exit) {
            Fluttertoast.showToast(
              msg: "You've exited the geofenced area.",
              toastLength: Toast.LENGTH_LONG,
            );
          }
        },
        onError: (error) {
          print("Geofencing Error: $error");
          Fluttertoast.showToast(
            msg: "Error setting up geofence: $error",
            toastLength: Toast.LENGTH_LONG,
          );
        },
      );
    }

    Fluttertoast.showToast(
      msg: "Geofence set successfully! You will be reminded when you reach home.",
      toastLength: Toast.LENGTH_LONG,
    );

    Navigator.pop(context);
  }

  Future<void> _showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      'geofenceChannelId',
      'Geofence Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Welcome Home',
      "I see you're home. Don't forget to do your exercises.",
      generalNotificationDetails,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.9,
            child: GoogleMap(
              onMapCreated: _onMapCreated,

              initialCameraPosition: CameraPosition(
                target: widget.initialLocation,
                zoom: 15.0,
              ),
              onTap: _onTap,
              markers: _userLocationMarker != null ? {_userLocationMarker!} : {},
              circles: _userLocationCircle != null ? {_userLocationCircle!} : {},
            ),
          ),
          Slider(
            value: _radius,
            min: 100,
            max: 1500,
            divisions: 14,
            label: '${_radius.round()} meters',
            onChanged: (double value) {
              setState(() {
                _radius = value;
                _userLocationCircle = Circle(
                  circleId: CircleId('geofenceRadius'),
                  center: _selectedLocation!,
                  radius: _radius,
                  fillColor: Colors.blue.withOpacity(0.3),
                  strokeColor: Colors.blue,
                  strokeWidth: 1,
                );
              });
            },
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _setGeofence,
        label: const Text('Set Geofence'),
        icon: const Icon(Icons.check),
        tooltip: 'Set Geofence',
      ),
    );
  }
}