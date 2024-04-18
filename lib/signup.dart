import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:image_picker/image_picker.dart';
import 'choix.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstInfoScreen(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF039e8e),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF039e8e)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF039e8e),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.white60),
          prefixIconColor: Color(0xFF039e8e),
        ),
      ),
    );
  }
}

class FirstInfoScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final String imagePath = 'assets/image1.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [

              ],
            ),
            Text(
              'Veuillez vous présenter',
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            Image.asset(imagePath),
            SizedBox(height: 30.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Color(0xFF039e8e)),
                hintText: 'Nom complet',
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
                  MaterialPageRoute(builder: (context) => SecondInfoScreen()),
                );
              },
              child: Text('Suivant', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondInfoScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final String imagePath = 'assets/image2.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Informations de contact',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
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
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Image.asset(imagePath),
            SizedBox(height: 22.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Color(0xFF039e8e)),
                hintText: 'Adresse email',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {},
              onInputValidated: (bool value) {},
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Color(0xFF039e8e)),
              textFieldController: phoneController,
              formatInput: false,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              inputDecoration: InputDecoration(
                prefixIcon: Icon(Icons.phone, color: Color(0xFF039e8e)),
                hintText: 'Numéro du téléphone',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.white60),
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
                  MaterialPageRoute(builder: (context) => VehicleInfoPage()),
                );
              },
              child: Text('Suivant', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sidePadding = 20.0;
    double elementSpacing = 10.0;
    double titleFontSize = 28.0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Informations du véhicule',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Entrer les informations sur votre véhicule (*facultatif)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: titleFontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: elementSpacing * 5),
            _buildInputField(context, 'Marque', Icons.directions_car),
            SizedBox(height: elementSpacing),
            _buildInputField(context, 'Plaque d\'immatriculation', Icons.featured_video),
            SizedBox(height: elementSpacing),
            _buildInputField(context, 'Nombre de places', Icons.event_seat),
            SizedBox(height: elementSpacing * 8),
            _buildRoundedButton(context, 'Suivant', Color(0xFF039e8e), Colors.black),
            SizedBox(height: elementSpacing),
            _buildRoundedButton(context, 'Dépasser cette étape', Colors.grey, Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context, String label, IconData icon) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        fillColor: Colors.grey.shade800,
        filled: true,
        prefixIcon: Icon(icon, color: Color(0xFF039e8e)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildRoundedButton(BuildContext context, String text, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DrivingLicenseInfoScreen()),
        );
      },
      child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}

class DrivingLicenseInfoScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, String side) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Ajoutez cette ligne
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
            SizedBox(height: 20),
            _buildButton(context, 'Insérer le verso de votre permis', Icons.image, () => _pickImage(context, 'back')),
            SizedBox(height: 20),
            _buildButton(context, 'Insérer votre photo d\'identité', Icons.image, () => _pickImage(context, 'identity_photo')),
            SizedBox(height: 40),
            _buildRoundedButton(context, 'Suivant', Color(0xFF039e8e), Colors.black),
            SizedBox(height: 20),
            _buildRoundedButton(context, 'Passer cette étape', Colors.grey, Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, Function() onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade800,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          SizedBox(width: 10),
          Icon(icon, color: Color(0xFF039e8e), size: 24.0),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildRoundedButton(BuildContext context, String text, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: EdgeInsets.symmetric(vertical: 20.0),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MotDepasse()),
        );
      },
      child: Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    );
  }
}

class MotDepasse extends StatelessWidget {
  final IconData lockIcon = Icons.lock;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,  // Ajoutez cette ligne
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Introduire un mot de passe',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/image4.jpeg',
              height: 300,
              width: 300,
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  filled: true,
                  fillColor: Colors.grey[800],
                  prefixIcon: Icon(lockIcon, color: Color(0xFF039e8e)),
                  suffixIcon: Icon(Icons.visibility, color: Color(0xFF039e8e)),
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmer votre mot de passe',
                  filled: true,
                  fillColor: Colors.grey[800],
                  prefixIcon: Icon(lockIcon, color: Color(0xFF039e8e)),
                  suffixIcon: Icon(Icons.visibility, color: Color(0xFF039e8e)),
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Acceuil(),));
              },
              child: Text('Suivant', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF039e8e),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.symmetric(horizontal: 155, vertical: 20),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}