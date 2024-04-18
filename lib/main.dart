import 'package:flutter/material.dart';
import 'welcome.dart'; // Assurez-vous que le fichier contenant la classe WelcomeScreen est correctement nommé et accessible
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC6rdntPjRF9OYFZ_AGIiAtyThkRNdKmyI",
      appId: "1:628850008645:android:0cc434b4ba1b6cf896792c",
      messagingSenderId: "628850008645",
      projectId: "covoiturage-82f8b",
    ),
  )
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp est le widget racine qui configure l'apparence et la navigation de l'application
    return MaterialApp(
      title: 'Navigation Demo',  // Le titre de l'application, utilisé dans le sélecteur de tâches
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Définit le thème global de l'application, ici avec une couleur principale bleue
      ),
      home: WelcomeScreen(),  // Définit l'écran initial de l'application, qui est WelcomeScreen
    );
  }
}
