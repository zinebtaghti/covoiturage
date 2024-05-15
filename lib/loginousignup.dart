import 'package:covoiturage/welcome.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

class SignUpOrLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'loginorsignup',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        buttonTheme: ButtonThemeData(buttonColor: Color(0xFF039E8E)),
      ),
      home: SelectionScreen(),
    );
  }
}

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Veuillez sélectionner votre choix!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: Image.asset(
              'assets/3.jpeg', // Replace with your image's asset path
              height: 300, // Adjust the height to fit your needs
              width: 300, // Set the height to 100, or any other value you want
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginIn()),
                );
              },
              child: Text('Se connecter'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color(0xFF039E8E), // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: Size(double.infinity, 60), // Élargit le bouton pour qu'il occupe toute la largeur avec une hauteur de 60
                textStyle: TextStyle(fontSize: 20), // Change la taille de la police
              ),
            ),
          ),
          SizedBox(height: 12), // Ajoute un espace vertical entre les boutons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text('S\'inscrire'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey, // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: Size(double.infinity, 60), // Élargit le bouton pour qu'il occupe toute la largeur avec une hauteur de 60
                textStyle: TextStyle(fontSize: 20), // Change la taille de la police
              ),
            ),
          ),
        ],
      ),
    );
  }
}
