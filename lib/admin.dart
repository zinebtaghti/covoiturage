import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

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
  List<DocumentSnapshot>? _userDocuments; // Liste des documents d'utilisateurs Firebase

  @override
  void initState() {
    super.initState();
    // Récupérer la liste des documents d'utilisateurs Firebase lors de l'initialisation du widget
    _getFirestoreUsers();
  }

  // Méthode pour récupérer la liste des documents d'utilisateurs à partir de Firestore
  Future<void> _getFirestoreUsers() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      setState(() {
        _userDocuments = querySnapshot.docs;
      });
    } catch (e) {
      print('Erreur lors de la récupération des utilisateurs Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer les utilisateurs'),
      ),
      body: Container(
        color: Colors.black,
        child: _userDocuments != null
            ? ListView.builder(
          itemCount: _userDocuments!.length,
          itemBuilder: (context, index) {
            final userData = _userDocuments![index].data() as Map<String, dynamic>;
            final userName = userData['email'] ?? 'Utilisateur ${index + 1}';
            return Card(
              color: Colors.grey[900],
              child: ListTile(
                title: Text(
                  userName,
                  style: TextStyle(color: Colors.white),
                ),
                // Ajoutez les actions pour chaque utilisateur ici
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.warning, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showWarningDialog(context, userName);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.block, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showBlockDialog(context, userName);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showDeleteDialog(context, _userDocuments![index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, DocumentSnapshot userDoc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userName = userData['email'] ?? 'Utilisateur';

        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Confirmation', style: TextStyle(color: Colors.white)),
          content: Text('Voulez-vous vraiment supprimer $userName?', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () async {
                try {
                  // Supprimer le document de l'utilisateur de Firestore
                  await FirebaseFirestore.instance.collection('users').doc(userDoc.id).delete();
                  // Actualiser l'interface utilisateur
                  setState(() {
                    _userDocuments!.remove(userDoc);
                  });
                  // Fermer la boîte de dialogue
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Erreur lors de la suppression de l\'utilisateur: $e');
                  // Afficher un message d'erreur si la suppression échoue
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erreur lors de la suppression de l\'utilisateur.'),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showBlockDialog(BuildContext context, String user) {
    final userDoc = _userDocuments!.firstWhere((doc) => doc['email'] == user);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userName = userData['email'] ?? 'Utilisateur';
        final bool isBlocked = userData['blocked'] ?? false; // Vérifier si le compte est déjà bloqué

        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Confirmation', style: TextStyle(color: Colors.white)),
          content: Text('Voulez-vous vraiment bloquer $userName?', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Bloquer', style: TextStyle(color: Color(0xFF039e8e))),
              onPressed: () async {
                try {
                  // Mettre à jour le champ 'blocked' dans Firestore pour marquer le compte comme bloqué
                  await FirebaseFirestore.instance.collection('users').doc(userDoc.id).update({'blocked': true});
                  // Actualiser l'interface utilisateur
                  setState(() {
                    _userDocuments!.remove(userDoc);
                  });
                  // Fermer la boîte de dialogue
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Erreur lors du blocage du compte: $e');
                  // Afficher un message d'erreur si le blocage échoue
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Erreur lors du blocage du compte.'),
                  ));
                }
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
                //
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
    return FutureBuilder(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else {
          int totalUsers = snapshot.data?['totalUsers'];
          int totalTrips = snapshot.data?['totalTrips'];
          List<UserData> userData = snapshot.data?['userData'];

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
                    SizedBox(height: 8), // Espacement entre les deux lignes de texte
                    Row(
                      children: [
                        Icon(Icons.info, color: Color(0xFF039e8e)),
                        SizedBox(width: 8),
                        Text(
                          'Total des trajets: $totalTrips',
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
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                              '${userData[index].name} (${userData[index].rating
                                  .toStringAsFixed(1)}) - ${userData[index]
                                  .trips} trajets',
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            ...userData[index].comments.map((comment) =>
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text('• $comment',
                                      style: TextStyle(color: Colors.white)),
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
      },
    );
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
          'users').get();
      int totalUsers = querySnapshot.size;
      int totalTrips = 0; // Ajout du total des trajets
      List<UserData> userData = querySnapshot.docs.map((doc) {
        final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        final String name = data != null && data.containsKey('name')
            ? data['name']
            : 'Utilisateur';
        double rating = data != null && data.containsKey('rating')
            ? data['rating']
            : 0.0;
        int trips = data != null && data.containsKey('trips')
            ? data['trips']
            : 0;
        List<String> comments = data != null && data.containsKey('comments')
            ? List<String>.from(data['comments'])
            : [];

        // Ajout des exemples de commentaires
        if (name == 'zineb taghti') {
          rating = 4.5;
          trips = 10;
          comments.addAll(['Bon travail!', 'Très professionnel']);
        } else if (name == 'asmae lahlou') {
          rating = 3.7;
          trips = 7;
          comments.addAll(['Sympathique', 'Bon conducteur']);
        } else if (name == 'younes') {
          rating = 3.7;
          trips = 7;
          comments.addAll(['très gentil', 'Bonne personne']);
        }

        totalTrips += trips; // Mise à jour du total des trajets

        return UserData(
          name: name,
          rating: rating,
          trips: trips,
          comments: comments,
        );
      }).toList();

      return {
        'totalUsers': totalUsers,
        'totalTrips': totalTrips,
        'userData': userData
      };
    } catch (e) {
      throw 'Erreur lors de la récupération des données utilisateur: $e';
    }
  }
}
  class UserData {
  final String name;
  final double rating;
  final int trips;
  final List<String> comments;

  UserData({required this.name, required this.rating, required this.trips, required this.comments});
}