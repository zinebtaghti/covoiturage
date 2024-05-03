import 'package:flutter/material.dart';
import 'trajetpassager.dart';
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
  DriverTrip(departureLocation: 'paris', destination: 'lyon', price: 50, departureTime: DateTime(2024, 4, 1, 9, 0)),
  DriverTrip(departureLocation: 'Lyon', destination: 'Marseille', price: 70.0, departureTime: DateTime(2024, 4, 1, 10, 0)),
  DriverTrip(departureLocation: 'Paris', destination: 'Marseille', price: 80.0, departureTime: DateTime(2024, 4, 1, 8, 0)),
];

class Rechercher extends StatefulWidget {
  @override
  _RechercherState createState() => _RechercherState();
}

class _RechercherState extends State<Rechercher> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<DriverTrip> matchingTrips = [];
  bool noMatchingTrips = false; // Variable pour suivre si aucun trajet correspondant n'est trouvé

  // Fonction de comparaison des trajets
  void matchTrips() {
    setState(() {
      matchingTrips.clear();
      noMatchingTrips = true; // Initialisation à true, changé à false s'il y a des trajets correspondants
      for (var trip in driverTrips) {
        // Comparez les informations du trajet du conducteur avec celles saisies par le passager
        if (trip.departureLocation == locationController.text &&
            trip.destination == destinationController.text &&
            trip.price <= double.parse(priceController.text)) {
          matchingTrips.add(trip);
          noMatchingTrips = false; // Il y a au moins un trajet correspondant
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
                                    );
                                  },
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TrajetPassager()), // Naviguer vers l'écran TrajetPassager
                                    );
                                  },
                                  child: Text('Choisir'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Afficher les trajets disponibles'),
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
          ],
        ),
      ),
    );
  }
}