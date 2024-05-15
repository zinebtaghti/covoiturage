import 'package:covoiturage/publiertrajet.dart';
import 'package:covoiturage/trajetpassager.dart';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:location/location.dart' as Loc;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PassengerTrip {
  final String departureLocation;
  final String destination;
  final double price;
  final String passengerName;

  PassengerTrip({
    required this.departureLocation,
    required this.destination,
    required this.price,
    required this.passengerName,
  });

  factory PassengerTrip.fromFirestore(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PassengerTrip(
      departureLocation: data['departureLocation'],
      destination: data['destination'],
      price: data['price'].toDouble(),
      passengerName: data['passengerName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'departureLocation': departureLocation,
      'destination': destination,
      'price': price,
      'passengerName': passengerName,
    };
  }
}

class DriverTrip {
  final String departureLocation;
  final String destination;
  final double price;
  final String driverName;

  DriverTrip({
    required this.departureLocation,
    required this.destination,
    required this.price,
    required this.driverName,
  });

  factory DriverTrip.fromFirestore(DocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return DriverTrip(
      departureLocation: data['departureLocation'],
      destination: data['destination'],
      price: data['price'].toDouble(),
      driverName: data['driverName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'departureLocation': departureLocation,
      'destination': destination,
      'price': price,
      'driverName':driverName,
    };
  }
}

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Rechercher(),
    );
  }
}

class Rechercher extends StatefulWidget {
  @override
  _RechercherState createState() => _RechercherState();
}

class _RechercherState extends State<Rechercher> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool noMatchingTrips = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationName();
  }

  Future<void> _getCurrentLocationName() async {
    Loc.Location location = Loc.Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    Loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == Loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != Loc.PermissionStatus.granted) return;
    }

    Loc.LocationData currentLocation = await location.getLocation();
    double latitude = currentLocation.latitude ?? 0.0;
    double longitude = currentLocation.longitude ?? 0.0;

    try {
      List<Geo.Placemark> placemarks = await Geo.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Geo.Placemark placemark = placemarks.first;
        locationController.text = "${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}";
      } else {
        locationController.text = "Unknown location";
      }
    } catch (e) {
      print("Erreur pendant la géocodification : $e");
      locationController.text = "Location not available";
    }
  }

  Stream<List<DriverTrip>> getTripsStream() {
    String departureLocation = locationController.text.trim().toLowerCase();
    String destination = destinationController.text.trim().toLowerCase();
    double price = double.tryParse(priceController.text) ?? double.infinity;

    print("Searching for trips from $departureLocation to $destination with max price $price");

    return firestore
        .collection('DriverTrip')
        .where('departureLocation', isEqualTo: departureLocation)
        .where('destination', isEqualTo: destination)
        .where('price', isLessThanOrEqualTo: price)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => DriverTrip.fromFirestore(doc)).toList());
  }

  Future<void> matchTrips() async {
    // Mettre à jour l'état pour indiquer qu'une recherche est en cours
    setState(() {
      noMatchingTrips = true;
    });
    User? user = _auth.currentUser;
    if (user != null) {
      // Récupérer les informations de l'utilisateur
      DocumentSnapshot userDoc = await firestore.collection('users').doc(
          user.uid).get();
      String passengerName = userDoc['name'];

      // Ajouter les informations du trajet passager à la base de données
      await firestore.collection('PassengerTrip').add({
        'departureLocation': locationController.text.trim().toLowerCase(),
        'destination': destinationController.text.trim().toLowerCase(),
        'price': double.tryParse(priceController.text) ?? 0.0,
        'passengerName': passengerName,
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rechercher un trajet"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Remplir les cases suivantes avec vos données convenables',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: locationController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Localisation actuelle',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.location_on, color: Colors.teal),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: destinationController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Destination',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.flag, color: Colors.teal),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: priceController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Prix',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: matchTrips,
              child: Text('Rechercher un trajet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 17.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            StreamBuilder<List<DriverTrip>>(
              stream: getTripsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Aucun trajet correspondant trouvé.', style: TextStyle(color: Colors.red)),
                  );
                } else {
                  List<DriverTrip> trips = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        for (var trip in trips)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                title: Text(
                                  'Départ: ${trip.departureLocation}, Destination: ${trip.destination}, Prix: ${trip.price}, Nom du conducteur: ${trip.driverName}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Heure de départ: À l\'instant',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TrajetPassager(source: '', destination: '',)),
                                        );
                                      },
                                      child: Text('Accepter'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white,
                                        textStyle: TextStyle(fontSize: 16.0),
                                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {

                                      },
                                      child: Text('Refuser'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        foregroundColor: Colors.white,
                                        textStyle: TextStyle(fontSize: 16.0),
                                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.white),
                            ],
                          ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}