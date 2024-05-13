import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as Geo;
import 'package:location/location.dart' as Loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'trajetconducteur.dart';

class DriverTrip {
  final String departureLocation;
  final String destination;
  final double price;
  final DateTime departureTime;

  DriverTrip({
    required this.departureLocation,
    required this.destination,
    required this.price,
    required this.departureTime,
  });

  factory DriverTrip.fromFirestore(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return DriverTrip(
      departureLocation: data['departureLocation'],
      destination: data['destination'],
      price: data['price'].toDouble(),
      departureTime: data['departureTime'].toDate(),
    );
  }
}

void main() async {
  // Initialisez Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Publier(),
    );
  }
}

class Publier extends StatefulWidget {
  @override
  _PublierState createState() => _PublierState();
}

class _PublierState extends State<Publier> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  Loc.Location location = Loc.Location();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<DriverTrip> driverTrips=[];
  List<DriverTrip> matchingTrips = [];
  bool noMatchingTrips = false;
  bool showAvailableTripsButton = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocationName();
  }
  Future<void> _getCurrentLocationName() async {
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

  Future<void> matchTrips() async {
    setState(() {
      matchingTrips.clear();
      noMatchingTrips = true;
    });

    // Ajouter les données de trajet à Firestore
    await firestore.collection('DriverTrip').add({
      'departureLocation': locationController.text,
      'destination': destinationController.text,
      'price': double.tryParse(priceController.text) ?? 0.0,
      'timestamp': DateTime.now(), // Ajouter une horodatage pour faciliter la recherche
    });

    // Rechercher les passagers avec des informations similaires
    QuerySnapshot querySnapshot = await firestore.collection('DriverTrip')
        .where('departureLocation', isEqualTo: locationController.text.toLowerCase())
        .where('destination', isEqualTo: destinationController.text.toLowerCase())
        .where('price', isLessThanOrEqualTo: double.tryParse(priceController.text) ?? 0.0)
        .get();

    querySnapshot.docs.forEach((doc) {
      DriverTrip trip = DriverTrip.fromFirestore(doc);
      setState(() {
        matchingTrips.add(trip);
        noMatchingTrips = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            customTextField(locationController, 'Localisation actuelle', Icons.location_on),
            SizedBox(height: 20),
            customTextField(destinationController, 'Destination', Icons.flag),
            SizedBox(height: 20),
            customTextField(priceController, 'Prix', Icons.attach_money, isNumeric: true),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: matchTrips,
              child: Text('Publier un trajet'),
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
            if (showAvailableTripsButton)
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Trajets disponibles'),
                        content: Container(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: matchingTrips.length,
                            itemBuilder: (context, index) {
                              var trip = matchingTrips[index];
                              return ListTile(
                                title: Text('Départ: ${trip.departureLocation} - Destination: ${trip.destination} - Prix: ${trip.price}'),
                                subtitle: Text('Heure de départ: ${trip.departureTime}'),
                                onTap: () => chooseTrip(index),
                              );
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TrajetConducteur(source: '', destination: '',)),
                              );
                            },
                            child: Text('choisir'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Afficher les trajets disponibles'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
              ),
            if (noMatchingTrips)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Aucun trajet correspondant trouvé.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void chooseTrip(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TrajetConducteur(
          source: matchingTrips[index].departureLocation,
          destination: matchingTrips[index].destination,
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String hintText, IconData icon, {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      keyboardType: isNumeric ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.teal),
        filled: true,
        fillColor: Colors.grey[850], // Dark gray fill
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
