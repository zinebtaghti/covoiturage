import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black, // Background color set to black
      ),
      home: MotDepasse(),
    );
  }
}

class MotDepasse extends StatelessWidget {
  final IconData lockIcon = Icons.lock; // Définition de l'icône du verrou

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // App bar color set to black
        //title: Text('SE CONNECTER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Introduire un mot de passe',
              style: TextStyle(fontSize: 28, color: Colors.white), // Text color set to white
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/image4.jpeg', // Path to your image asset
              height: 300,
              width:300,// Adjust height as needed
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  filled: true,
                  fillColor: Colors.grey[800], // Text field color set to grey
                  prefixIcon: Icon(lockIcon, color: Color(0xFF039e8e)), // Icon color set to teal
                  suffixIcon: Icon(Icons.visibility, color: Color(0xFF039e8e)), // Password visibility icon
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white), // Label text color set to white
                ),
              ),
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmer votre mot de passe',
                  filled: true,
                  fillColor: Colors.grey[800],
                  prefixIcon: Icon(lockIcon, color: Color(0xFF039e8e)), // Same icon for "Confirmer votre mot de passe"
                  suffixIcon: Icon(Icons.visibility, color: Color(0xFF039e8e)), // Same visibility icon for "Confirmer votre mot de passe"
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white), // Label text color set to white
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique pour gérer la connexion
              },
              child: Text('Suivant', style: TextStyle(color: Colors.black)), // Setting text color to black
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF039e8e), // Button color set to teal
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.symmetric(horizontal: 155, vertical: 20), // Padding inside the button// Rounding button corners
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}