import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final Location _location = Location();
  final TextEditingController _destinationController = TextEditingController();
  bool _isNavigating = false;

  // Coordinates for the Fontys R10 building
  final LatLng _fontysR10Location = LatLng(51.4525, 5.4801);

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    final currentLocation = await _location.getLocation();

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            currentLocation.latitude ?? _fontysR10Location.latitude,
            currentLocation.longitude ?? _fontysR10Location.longitude,
          ),
          zoom: 17.0,
        ),
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    final status = await _location.requestPermission();
    if (status == PermissionStatus.granted) {
      _setInitialLocation();
    } else {
      // Handle the case when permission is not granted
    }
  }

  void _searchAndNavigate() async {
    if (_destinationController.text.isEmpty) return;

    try {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(_destinationController.text);
      if (locations.isNotEmpty) {
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(locations.first.latitude, locations.first.longitude),
              zoom: 14.0,
            ),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      // Handle or show error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _destinationController,
          decoration: InputDecoration(
            hintText: 'Enter destination',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: _searchAndNavigate,
            ),
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _fontysR10Location,
          zoom: 17.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isNavigating = !_isNavigating;
          });
          // Add additional logic for starting or stopping navigation if required
        },
        backgroundColor: _isNavigating ? Colors.red : Colors.green,
        child: Icon(_isNavigating ? Icons.close : Icons.navigation),
      ),
    );
  }
}
