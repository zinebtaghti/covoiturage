import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:geocoding/geocoding.dart';
import 'evaluerpassager.dart'; // Assurez-vous d'importer DriverRatingScreen

class MapScreen extends StatefulWidget {
  final String source;
  final String destination;

  MapScreen({required this.source, required this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapBoxNavigation _navigation;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _navigation = MapBoxNavigation();
    _setupNavigation();
  }

  Future<void> _setupNavigation() async {
    var origin = await _getCoordinates(widget.source);
    var destination = await _getCoordinates(widget.destination);
    if (origin != null && destination != null) {
      List<WayPoint> wayPoints = [origin, destination];
      await _navigation.startNavigation(
        wayPoints: wayPoints,
        options: MapBoxOptions(
          mode: MapBoxNavigationMode.drivingWithTraffic,
          simulateRoute: false,
          language: "fr",
          units: VoiceUnits.metric,
          voiceInstructionsEnabled: false,
          bannerInstructionsEnabled: true,
        ),
      );
      setState(() {
        _isNavigating = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to find one or both locations'))
      );
    }
  }

  Future<WayPoint?> _getCoordinates(String locationName) async {
    try {
      List<Location> locations = await locationFromAddress(locationName);
      if (locations.isNotEmpty) {
        final location = locations.first;
        return WayPoint(name: locationName, latitude: location.latitude, longitude: location.longitude);
      }
    } catch (e) {
      print('Error during geocoding: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Map"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          _isNavigating
              ? MapBoxNavigationView(
            onCreated: (MapBoxNavigationViewController controller) async {},
          )
              : Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PassengerRatingScreen(),
                ));
              },
              label: Text('Évaluer passager'),
              icon: Icon(Icons.star),
              backgroundColor: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}