import 'package:flutter/material.dart';



class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHome(),
    );
  }
}

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 20.0),
            child: Text(
              'Espace d\'administrateur',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset('assets/image5.png', scale: 1.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF039e8e),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageUsers()),
                    );
                  },
                  child: Text('Gérer les utilisateurs', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF039e8e),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminDashboard()),
                    );
                  },
                  child: Text('Voir les rapports et les statistiques', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  List<String> users = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5', 'User 6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Gérer les utilisateurs',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[900],
              child: ListTile(
                title: Text(
                  users[index],
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.warning, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showWarningDialog(context, users[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.block, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showBlockDialog(context, users[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showDeleteDialog(context, users[index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Confirmation', style: TextStyle(color: Colors.white)),
          content: Text('Voulez-vous vraiment supprimer $user?', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                setState(() {
                  users.remove(user);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBlockDialog(BuildContext context, String user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Confirmation', style: TextStyle(color: Colors.white)),
          content: Text('Voulez-vous vraiment bloquer $user?', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Bloquer', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                // Implementer la fonction de blocage ici
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showWarningDialog(BuildContext context, String user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Confirmation', style: TextStyle(color: Colors.white)),
          content: Text('Voulez-vous vraiment envoyer un avertissement à $user?', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Avertir', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                // Implementer la fonction d'avertissement ici
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'Tableau de bord admin',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      ...userData[index].comments.map((comment) => Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text('• $comment', style: TextStyle(color: Colors.white)),
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