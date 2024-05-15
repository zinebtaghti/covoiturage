// welcome_screen.dart
import 'package:flutter/material.dart';
import 'loginousignup.dart';
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Arrière-plan noir
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/2.jpeg', // Remplacer par votre chemin d'assets
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpOrLogin(),));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF039E8E)), // Bouton vert
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
              ),
              child: Text(
                'Essaie CoYAZ maintenant!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
