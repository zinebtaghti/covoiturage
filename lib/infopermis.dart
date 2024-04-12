import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrivingLicenseInfoScreen(),
    );
  }
}

class DrivingLicenseInfoScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, String side) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // L'image peut être stockée ou utilisée ici
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Entrer les informations sur votre permis de conduire (*facultatif)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            _buildButton(context, 'Insérer le recto de votre permis', Icons.image, () => _pickImage(context, 'front')),
            SizedBox(height: 20),  // Augmentation de l'espace ici
            _buildButton(context, 'Insérer le verso de votre permis', Icons.image, () => _pickImage(context, 'back')),
            SizedBox(height: 20),  // Augmentation de l'espace ici
            _buildButton(context, 'Insérer votre photo d\'identité', Icons.image, () => _pickImage(context, 'identity_photo')),
            SizedBox(height: 40),
            _buildRoundedButton(context, 'Suivant', Color(0xFF039e8e), Colors.black),
            SizedBox(height: 20),  // Augmentation de l'espace ici
            _buildRoundedButton(context, 'Passer cette étape', Colors.grey, Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, Function() onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.grey.shade800, // Text color
        padding: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),  // Augmentation de l'espace avant l'icône ici
          Icon(icon, color: Color(0xFF039e8e), size: 24.0),
          SizedBox(width: 10),  // Espacement entre l'icône et le texte
          Text(text),
        ],
      ),
    );
  }

  Widget _buildRoundedButton(BuildContext context, String text, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, // Text color
        backgroundColor: backgroundColor, // Button color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.symmetric(vertical: 20.0),
      ),
      onPressed: () {},
      child: Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    );
  }
}
