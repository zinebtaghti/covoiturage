import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

// Classe représentant un trajet (pour les passagers)
class PassengerTrip {
  final String departureLocation;
  final String destination;
  final double price;
  final DateTime departureTime;

  PassengerTrip({required this.departureLocation, required this.destination, required this.price, required this.departureTime});
}

// Classe représentant un trajet de conducteur
class DriverTrip {
  final String departureLocation;
  final String destination;
  final double price;
  final DateTime departureTime;

  DriverTrip({required this.departureLocation, required this.destination, required this.price, required this.departureTime});
}

// Liste des trajets de conducteurs (simulons une liste statique ici)
List<DriverTrip> driverTrips = [
  DriverTrip(departureLocation: 'Paris', destination: 'Lyon', price: 50.0, departureTime: DateTime(2024, 4, 1, 9, 0)),
  DriverTrip(departureLocation: 'Lyon', destination: 'Marseille', price: 70.0, departureTime: DateTime(2024, 4, 1, 10, 0)),
  DriverTrip(departureLocation: 'Paris', destination: 'Marseille', price: 80.0, departureTime: DateTime(2024, 4, 1, 8, 0)),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recherche Trajet',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade800,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
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

  List<DriverTrip> matchingTrips = [];

  // Fonction de comparaison des trajets
  void matchTrips() {
    setState(() {
      matchingTrips.clear();
      for (var trip in driverTrips) {
        // Comparez les informations du trajet du conducteur avec celles saisies par le passager
        if (trip.departureLocation == locationController.text &&
            trip.destination == destinationController.text &&
            trip.price <= double.parse(priceController.text)) {
          matchingTrips.add(trip);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/5.jpeg',
                height: 300,
                width: 400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Remplir les cases suivantes avec vos données',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 23.0),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: 'Localisation actuelle',
                      prefixIcon: Icon(Icons.location_on, color: Colors.teal),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: destinationController,
                    decoration: InputDecoration(
                      hintText: 'Destination',
                      prefixIcon: Icon(Icons.flag, color: Colors.teal),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'Prix',
                      prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: matchTrips,
                    child: Text('Rechercher un trajet'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.black,
                      textStyle: TextStyle(
                        fontSize: 17.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Affichage des résultats du matching
                  if (matchingTrips.isNotEmpty)
                    Column(
                      children: matchingTrips.map((trip) {
                        return ListTile(
                          title: Text('Départ: ${trip.departureLocation} - Destination: ${trip.destination} - Prix: ${trip.price}'),
                          subtitle: Text('Heure de départ: ${trip.departureTime}'),
                        );
                      }).toList(),
                    ),
                  if (matchingTrips.isEmpty)
                    Text('Aucun trajet correspondant trouvé.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}