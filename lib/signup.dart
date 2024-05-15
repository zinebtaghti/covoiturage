import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'choix.dart';
import 'loginousignup.dart';

class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstInfoScreen(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF039e8e),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFF039e8e),
        ),
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
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> saveUserInfoToFirestore(
      String name, CollectionReference usersCollection) async {
    try {
      await usersCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': name,
        'email': '', // Laisser vide car l'e-mail sera ajouté dans la deuxième étape
      });
      print('Nom sauvegardé avec succès dans Cloud Firestore');
    } catch (e) {
      print('Erreur lors de la sauvegarde du nom dans Cloud Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpOrLogin(),
              ),
            );
          },
        ),
        title: Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/image1.jpeg'), // Assurez-vous que le chemin vers l'image est correct
            Text(
              'Veuillez entrer votre nom complet',
              style: TextStyle(fontSize: 24.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
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
              onPressed: () async {
                String name = nameController.text;
                await saveUserInfoToFirestore(name, _usersCollection);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondInfoScreen(email: ''),
                  ),
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
class SecondInfoScreen extends StatefulWidget {
  final String email;

  SecondInfoScreen({required this.email});

  @override
  _SecondInfoScreenState createState() => _SecondInfoScreenState();
}

class _SecondInfoScreenState extends State<SecondInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }
  Future<void> saveUserInfoToFirestore(String name, String email, CollectionReference usersCollection) async {
    try {
      await usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'name': name,
        'email': email,
      });
      print('Nom et email sauvegardés avec succès dans Cloud Firestore');
    } catch (e) {
      print('Erreur lors de la sauvegarde du nom et de l\'email dans Cloud Firestore: $e');
    }
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;
          setState(() {
            nameController.text =
                userData['name'] ?? ''; // Assurez-vous que la clé dans Firestore est 'name'
            emailController.text = userData['email'] ?? user.email ?? '';
          });
        } else {
          // Utiliser le nom de l'utilisateur actuel s'il n'existe pas dans Firestore
          setState(() {
            nameController.text =
                user.displayName ?? ''; // Utilisez le nom d'affichage de l'utilisateur actuel
            emailController.text = user.email ?? '';
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des données de l\'utilisateur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
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
            Image.asset('assets/image2.png'),
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
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Color(0xFF039e8e)),
                hintText: 'Mot de passe',
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color(0xFF039e8e),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                String name = nameController.text;
                await saveUserInfoToFirestore(name, email, _usersCollection);
                try {
                  UserCredential userCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Acceuil()),
                  );
                } catch (e) {
                  print('Erreur d\'inscription: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erreur d\'inscription: $e'),
                    ),
                  );
                }
              },
              child:
              Text('S\'inscrire', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
