import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_database/firebase_database.dart';



class PassengerRatingScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PassengerRatingScreen(),
    );
  }



  @override
  _DriverRatingScreenState createState() => _DriverRatingScreenState();
}

class _DriverRatingScreenState extends State<PassengerRatingScreen> {
  double _rating = 0.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Évaluer le passager (*facultatif)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              SizedBox(height: 50.0),
              Container(
                width: 275,
                child: RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
              SizedBox(height: 80.0),
              Text(
                'Donner un commentaire sur le trajet(*facultatif)',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              SizedBox(height: 50.0),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "Commentaire...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white12,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Ajustez la valeur de vertical padding
                ),
                style: TextStyle(color: Colors.white),
                maxLines: 5, // Ajustez le nombre maximal de lignes
              ),

              SizedBox(height: 50.0),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, padding: EdgeInsets.all(16.0), // Text Color
                  backgroundColor: Color(0xFF039e8e), // Button Background Color
                  minimumSize: Size(double.infinity, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  // Logic to skip the step
                },
                child: Text(
                  'Confirmer',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, padding: EdgeInsets.all(16.0), // Text Color
                  backgroundColor: Color(0xFF039e8e), // Button Background Color
                  minimumSize: Size(double.infinity, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  // Logic to skip the step
                },

                child: Text(
                  'Passer cette étape',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _submitRating() {
    double rating = _rating;
    String comment = _commentController.text;

    // Référence à la base de données Firebase Realtime Database
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

    // Enregistrer les données dans Firebase Realtime Database
    databaseReference.child('ratings').push().set({
      'rating': rating,
      'comment': comment,
    }).then((_) {
      // Afficher une boîte de dialogue pour confirmer que l'évaluation a été enregistrée
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Succès'),
            content: Text('Votre évaluation a été enregistrée avec succès !'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // En cas d'erreur lors de l'enregistrement des données
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text('Une erreur s\'est produite lors de l\'enregistrement de l\'évaluation. Veuillez réessayer.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}