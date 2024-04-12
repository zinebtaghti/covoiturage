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
      home: VehicleInfoPage(),
    );
  }
}

class VehicleInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Adjust these values for overall padding and spacing
    double sidePadding = 20.0;
    double elementSpacing = 10.0;
    double titleFontSize = 28.0; // Increased title font size

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // ensures full width
          children: [
            Text(
              'Entrer les informations sur votre véhicule (*facultatif)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: titleFontSize, fontWeight: FontWeight.bold), // Text is bold
            ),
            SizedBox(height: elementSpacing * 5), // More space after title
            _buildInputField(context, 'Marque', Icons.directions_car, Color(0xFF039e8e)),
            SizedBox(height: elementSpacing),
            SizedBox(height: elementSpacing),
            _buildInputField(context, 'Plaque d\'immatriculation', Icons.featured_video, Color(0xFF039e8e)),
            SizedBox(height: elementSpacing),
            SizedBox(height: elementSpacing),
            _buildInputField(context, 'Nombre de places', Icons.event_seat, Color(0xFF039e8e)),
            SizedBox(height: elementSpacing * 8), // More space before the 'Suivant' button
            _buildRoundedButton(context, 'Suivant', Color(0xFF039e8e), Colors.black),
            SizedBox(height: elementSpacing),
            SizedBox(height: elementSpacing),
            _buildRoundedButton(context, 'Dépasser cette étape', Colors.grey, Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context, String label, IconData icon, Color iconColor) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        fillColor: Colors.grey.shade800,
        filled: true,
        prefixIcon: Icon(icon, color: iconColor),
        border: _buildRoundedBorder(),
        enabledBorder: _buildRoundedBorder(),
        focusedBorder: _buildRoundedBorder(),
      ),
    );
  }

  OutlineInputBorder _buildRoundedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }

  Widget _buildRoundedButton(BuildContext context, String text, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: backgroundColor, // Button colors
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15), // Button padding
      ),
      onPressed: () {},
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Button text is bold
    );
  }
}
