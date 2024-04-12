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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'Soyer les bienvenues sur votre espace',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,

                  child: Image.asset(
                    "assets/1.jpeg",
                    fit: BoxFit.contain, // Cette propriété assure que l'image est entièrement visible, mais elle pourrait ne pas remplir tout l'espace si le ratio d'aspect est différent.
                  ),
                ),
                SizedBox(width: 4),
                SizedBox(height: 10),// Cette taille peut également être ajustée selon vos besoins.
              ],
            ),
            Text(
              'veillez séletionner votre choix!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),



            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, // Text color
                backgroundColor: Color(0xFF039E8E), // Custom green color
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // Perform some action
              },
              child: Text(
                'Chercher un trajet (passager)',
                style: TextStyle(
                  fontSize: 18, // Ajustez la taille du texte selon vos préférences
                ),
              ),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.grey, // Text color
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // Perform some action
              },
              child: Text(
                'Publier un trajet (condoucteur)',
                style: TextStyle(
                  fontSize: 18, // Ajustez la taille du texte selon vos préférences
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,  backgroundColor: Color(0xFF039E8E), // Text color
                minimumSize: Size(double.infinity, 50),

              ),
              onPressed: () {
                // Perform some action
              },
              child: Text(
                'Gérer votre profil',
                style: TextStyle(
                  fontSize: 18, // Ajustez la taille du texte selon vos préférences
                ),
              ),
            ),Spacer(),
          ],
        ),
      ),
    );
  }
}