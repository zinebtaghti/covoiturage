import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(AdminApp());
}


class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHome(),
    );
  }
}

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
            child: Text(
              'Espace d\'administrateur',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          // Placeholder for an image
          Expanded(
            child: Center(
              // Replace with Image.asset or Image.network
              child: Image.asset('assets/image5.png', scale: 1.0),
            ),
          ),
          // Buttons at the bottom
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF039e8e),
                    minimumSize: Size(double.infinity, 50), // sets minimum size
                  ),
                  onPressed: () {
                    // TODO: Add functionality for managing users
                  },
                  child: Text('Gérer les utilisateurs', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(height: 10), // Spacing between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF039e8e),
                    minimumSize: Size(double.infinity, 50), // sets minimum size
                  ),
                  onPressed: () {
                    // TODO: Add functionality for viewing reports and statistics
                  },
                  child: Text('Voir les rapports et les statistiques', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
