import 'recherchertrajet.dart';
import 'package:flutter/material.dart';
import 'publiertrajet.dart';
import 'gererprofil.dart';

class Acceuil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Empêche le retour arrière
      child: MaterialApp(
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(''),
            backgroundColor: Colors.black,
            elevation: 0, // Supprime l'ombre sous la barre d'applications
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Soyez les bienvenues sur votre espace',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Taille réduite
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8), // Réduire l'espace
                Flexible(
                  child: Center(
                    child: Image.asset(
                      'assets/1.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 8), // Réduire l'espace
                Text(
                  'Veuillez sélectionner votre choix!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Taille réduite
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8), // Réduire l'espace
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFF039E8E),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Rechercher()),
                    );
                  },
                  child: Text(
                    'Chercher un trajet (passager)',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 8), // Réduire l'espace
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Publier()),
                    );
                  },
                  child: Text(
                    'Publier un trajet (conducteur)',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 8), // Réduire l'espace
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFF039E8E),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileManagementScreen()),
                    );
                  },
                  child: Text(
                    'Gérer votre profil',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
