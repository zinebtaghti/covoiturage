import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Interface Example',
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
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'veillez sélectionner votre choix!',
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
                // TODO: Add log in functionality
              },
              child: Text('se connecter'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color(0xFF039E8E), // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: Size(double.infinity, 50), // Élargit le bouton pour qu'il occupe toute la largeur avec une hauteur de 50
              ),
            ),
          ),
          SizedBox(height: 12), // Ajoute un espace vertical entre les boutons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Add sign up functionality
              },
              child: Text('s\'inscrire'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor:  Colors.grey, // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: Size(double.infinity, 50), // Élargit le bouton pour qu'il occupe toute la largeur avec une hauteur de 50

              ),
            ),
          ),
        ],
      ),
    );
  }
}