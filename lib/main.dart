import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstInfoScreen(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF039e8e), // Couleur personnalisée pour les éléments de l'UI
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF039e8e)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF039e8e), // Boutons avec la couleur personnalisée
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0), // Boutons avec coins arrondis
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0), // Champs de texte avec coins arrondis
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.white60),
          prefixIconColor: Colors.white, // Couleur des icônes à l'intérieur des champs de texte
        ),
      ),
    );
  }
}
class FirstInfoScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final String imagePath = 'assets/image1.jpeg'; // Assurez-vous que l'image est dans vos assets.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Veuillez vous présenter',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            Image.asset(imagePath), // Assurez-vous que l'image existe dans le dossier d'assets
            SizedBox(height: 30.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), // Icône ajoutée ici
                hintText: 'Nom complet',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Bordures arrondies pour le TextField
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Color(0xFF039e8e), // Couleur du texte du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Bordures arrondies pour le bouton
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondInfoScreen()),
                );
              },
              child: Text('Suivant', style: TextStyle(color: Colors.black)), // Texte noir
            ),
          ],
        ),
      ),
    );
  }
}
class SecondInfoScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController(); // Contrôleur pour le numéro de téléphone
  final String imagePath = 'assets/image2.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adresse mail et Téléphone'),
        //backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView( // Utilisez SingleChildScrollView pour éviter les problèmes de débordement
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Entrez les informations du contact',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Image.asset(imagePath), // Image pour l'email
            SizedBox(height: 22.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'Adresse e-mail',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            // Ajout du champ de saisie du numéro de téléphone

            SizedBox(height: 20.0),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                // Vous pouvez utiliser le numéro de téléphone ici
              },
              onInputValidated: (bool value) {
                // Ici, vous pouvez gérer la validation de l'entrée
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
                prefixIcon: Icon(Icons.phone), // Ajout de l'icône de téléphone ici
                hintText: 'Numéro de téléphone',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              textStyle: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdInfoScreen()),
                );
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
class ThirdInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créez votre mot de passe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choisissez un mot de passe'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DrivingLicenseInfoScreen()),
                );
              },
              child: Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
class DrivingLicenseInfoScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, String side) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Vous pouvez stocker l'image ou effectuer des opérations avec elle
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permis de conduire'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Adjusted padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 36.0), // Adjusted space at the top
              Text('Téléchargez le recto de votre permis (facultatif)'),
              SizedBox(height: 24.0), // Adjusted space between text and button
              ElevatedButton(
                onPressed: () => _pickImage(context, 'front'),
                child: Text('Télécharger le recto'),
              ),
              SizedBox(height: 36.0), // Adjusted space between buttons
              Text('Téléchargez le verso de votre permis (facultatif)'),
              SizedBox(height: 24.0), // Adjusted space between text and button
              ElevatedButton(
                onPressed: () => _pickImage(context, 'back'),
                child: Text('Télécharger le verso'),
              ),
              SizedBox(height: 36.0), // Adjusted space between buttons
              Text('Entrez la date d\'expiration de votre permis (facultatif)'),
              SizedBox(height: 24.0), // Adjusted space between text and textfield
              TextField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'Date d\'expiration',
                ),
              ),
              SizedBox(height: 36.0), // Adjusted space after textfield
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IdentityVerificationScreen()),
                  );
                },
                child: Text('Continuer'),
              ),
              SizedBox(height: 36.0), // Adjusted space between buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Set the background color to grey
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompleteRegistrationScreen()),
                  );
                },
                child: Text('Passer cette étape'),
              ),
              // Removed the SizedBox here to ensure no space after the last button
            ],
          ),
        ),
      ),
    );
  }
}

class IdentityVerificationScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickIdentityImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Vous pouvez stocker l'image ou effectuer des opérations avec elle
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vérification de l\'identité'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Téléchargez une photo pour la vérification de l\'identité (facultatif)'),
            ElevatedButton(
              onPressed: () => _pickIdentityImage(context),
              child: Text('Télécharger la photo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompleteRegistrationScreen()),
                );
              },
              child: Text('Continuer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompleteRegistrationScreen()),
                );
              },
              child: Text('Passer cette étape'),
            ),
          ],
        ),
      ),
    );
  }
}
class VehicleInfoScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController plateNumberController = TextEditingController();

  Future<void> _pickVehicleDocument(BuildContext context, String documentType) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Stocker l'image ou effectuer des opérations avec elle
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations sur le véhicule'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Marque du véhicule'),
              TextField(
                controller: brandController,
                decoration: InputDecoration(
                  hintText: 'Marque',
                ),
              ),
              SizedBox(height: 24.0),
              Text('Plaque d\'immatriculation'),
              TextField(
                controller: plateNumberController,
                decoration: InputDecoration(
                  hintText: 'Plaque d\'immatriculation',
                ),
              ),
              SizedBox(height: 24.0),
              Text('Téléchargez la carte grise du véhicule'),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () => _pickVehicleDocument(context, 'vehicleRegistration'),
                child: Text('Télécharger la carte grise'),
              ),
              SizedBox(height: 36.0),
              ElevatedButton(
                onPressed: () {
                  // Procéder à l'étape suivante ou finaliser
                },
                child: Text('Continuer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CompleteRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalisation de l\'inscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Votre inscription est presque terminée !'),
            ElevatedButton(
              onPressed: () {
                // Terminez le processus d'inscription ici
              },
              child: Text('Terminer l\'inscription'),
            ),
          ],
        ),
      ),
    );
  }
}
