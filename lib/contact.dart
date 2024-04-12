import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informations de contact',
      theme: ThemeData.dark(), // Applique le thème sombre globalement
      home: SecondInfoScreen(),
    );
  }
}

class SecondInfoScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // Assurez-vous que le chemin de l'image est correct et que l'image existe dans les assets
  final String imagePath = 'assets/image2.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informations de contact',
          style: TextStyle(color: Colors.white), // Couleur du titre en blanc
        ),
        backgroundColor: Colors.black, // Couleur de fond de l'AppBar en noir
      ),
      backgroundColor: Colors.black, // Couleur de fond du Scaffold en noir
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Entrer les informations du contact',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white for better contrast
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Image.asset(imagePath), // Image for the email
            SizedBox(height: 22.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.white), // Ensure icon is visible against the dark background
                hintText: 'Adresse email',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.white60), // Hint text style
              ),
              style: TextStyle(color: Colors.white), // Input text style
            ),
            SizedBox(height: 20.0),
            // Phone number input field
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                // Handle the phone number change
              },
              onInputValidated: (bool value) {
                // Handle the input validation
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.white),
              textFieldController: phoneController,
              formatInput: false,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              inputDecoration: InputDecoration(
                prefixIcon: Icon(Icons.phone, color: Colors.white), // Phone icon
                hintText: 'Numéro du téléphone',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.white60), // Hint text style
              ),
              textStyle: TextStyle(color: Colors.white), // Input text style
              cursorColor: Colors.white, // Cursor color
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color(0xFF039e8e),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                // Handle the button press
              },
              child: Text(
                'Suivant',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
