import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MdpOublie extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _showResetSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Réinitialisation réussie"),
          content: Text("Email de réinitialisation du mot de passe est envoyé avec succès. Confirmez l'email."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetPassword(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      _showResetSuccessMessage(context);
    } catch (e) {
      print("Erreur lors de la réinitialisation du mot de passe: $e");
      // Afficher une boîte de dialogue pour informer l'utilisateur de l'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Une erreur s'est produite lors de la réinitialisation du mot de passe. Veuillez réessayer."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 60.0),
              Text(
                'Réinitialiser le mot de passe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                'Veuillez saisir votre e-mail ci-dessous.',
                style: TextStyle(color: Colors.white70, fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              Center(
                child: Image.asset(
                  'assets/4.jpeg', // Assurez-vous de remplacer par votre chemin d'assets
                  // Ajustez la taille selon vos besoins
                ),
              ),
              SizedBox(height: 40.0),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Adresse e-mail',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white24,
                  prefixIcon: Icon(Icons.email, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF039E8E), // Couleur personnalisée du bouton
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: Size(double.infinity, 50), // Largeur infinie, hauteur de 50
                ),
                onPressed: () {
                  _resetPassword(context); // Appeler la fonction de réinitialisation du mot de passe
                },
                child: Text(
                  'Envoyer l email de réinitialisation',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              SizedBox(height: 1.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginIn(),),
                  );
                },
                child: Text(
                  'Allez à la connexion?',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


