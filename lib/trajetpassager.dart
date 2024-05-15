import 'package:flutter/material.dart';
import 'chatconducteur.dart';
import 'suivi.dart'; // Assurez-vous d'importer le fichier correctement
import 'choix.dart';
class TrajetPassager extends StatelessWidget {
  final String source;
  final String destination;

  TrajetPassager({required this.source, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Définit le fond en noir
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ajouter une espace en haut
          SizedBox(height: 60),
          Center(
            child: Text(
              'Vous avez choisi votre conducteur',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Placez ici l'image après le texte
          Expanded(
            child: Image.asset("assets/image8.png", fit: BoxFit.contain),
          ),
          // Boutons au bas de l'écran
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircleButton(
                  context,
                  'Contacter conducteur',
                  Icons.phone,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                    print('Contacter conducteur');
                  },
                ),
                _buildCircleButton(
                  context,
                  'Suivre trajet',
                  Icons.map,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen(source: source, destination: destination)),
                    );
                    print('Suivre trajet');
                  },
                ),
                _buildCircleButton(
                  context,
                  'Annuler Réservation',
                  Icons.close,
                      () {
                    Navigator.pushReplacement( // Utiliser Navigator.pushReplacement pour empêcher le retour à l'écran précédent
                      context,
                      MaterialPageRoute(builder: (context) => Acceuil()),
                    );
                    print('Annuler Réservation');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RawMaterialButton(
          onPressed: onPressed,
          child: Icon(icon, color: Colors.white, size: 30.0),
          shape: CircleBorder(),
          padding: EdgeInsets.all(20.0),
          fillColor: Color(0xFF039E8E),
          elevation: 2.0,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}