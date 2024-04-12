import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(AdminApp());
}

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF212121), // Couleur de fond principal
        scaffoldBackgroundColor: Color(0xFF212121), // Couleur de fond de l'interface principale
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 25.0), // Utilisé pour le titre de l'appbar
          bodyText2: TextStyle(color: Colors.white), // Style de texte par défaut
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF00BCD4), // Couleur de fond des boutons
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        cardTheme: CardTheme(
          color: Color(0xFF424242), // Couleur pour les cartes et éléments en relief
        ),
      ),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalUsers = 100; // Exemple de donnée
    int totalTrips = 500; // Exemple de donnée
    List<UserData> userData = [
      UserData(name: 'John Doe', rating: 4.5, trips: 100, comments: [
        'Conducteur très fiable.',
        'Excellent service, toujours à l\'heure.',
      ]),
      UserData(name: 'Alice Smith', rating: 4.2, trips: 80, comments: [
        'Conducteur sympathique mais parfois en retard.',
        'Des trajets agréables dans l\'ensemble.',
      ]),
      // Ajoutez plus de données utilisateur ici
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de bord admin', textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 25.0),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: Color(0xFF039e8e)),
                  SizedBox(width: 8),
                  Text(
                    'Total des utilisateurs: $totalUsers',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Icon(Icons.directions_car, color: Color(0xFF039e8e)),
                  SizedBox(width: 8),
                  Text(
                    'Total des trajets effectués: $totalTrips',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Icon(Icons.info, color: Color(0xFF039e8e)),
                  SizedBox(width: 8),
                  Text(
                    'Informations sur les utilisateurs:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userData[index].name} (${userData[index].rating.toStringAsFixed(1)}) - ${userData[index].trips} trajets',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ...userData[index].comments.map((comment) => Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('• $comment'),
                      )).toList(),
                      Divider(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserData {
  final String name;
  final double rating;
  final int trips;
  final List<String> comments;

  UserData({required this.name, required this.rating, required this.trips, required this.comments});
}
