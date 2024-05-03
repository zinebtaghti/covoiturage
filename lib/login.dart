import 'mdpouli%C3%A9asmae.dart';
import 'signup.dart';
import 'choix.dart';
import 'package:flutter/material.dart';
import 'admin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginIn extends StatefulWidget {
  @override
  _LoginInState createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'SE CONNECTER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                'Connectez-vous avec votre compte',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'email',
                  prefixIcon: Icon(Icons.person, color: Colors.teal),
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock, color: Colors.teal),
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  String email = _usernameController.text;
                  String password = _passwordController.text;
                  if (email == 'admin@gmail.com' && password == 'adminadmin') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder:
    (context) => AdminScreen()), );
                  }
                  else{
    try {
    // Authentifier l'utilisateur avec Firebase Authentication
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
    );

    // Si l'authentification réussit, rediriger vers l'écran d'accueil
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Acceuil()),
    );
    } catch (e) {
    // Si l'authentification échoue, afficher un message d'erreur
    print('Erreur d\'authentification: $e');
    setState(() {
    _errorMessage = 'Email ou mot de passe incorrect.';
    });
    }
    }
    },





                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MdpOublie()),
                  );
                },
                child: Text(
                  'Mot de passe oublié?',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text(
                  'Pas encore inscrit?',
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
