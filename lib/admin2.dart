import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'gererprofil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}


class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHome(),
    );
  }
}

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<String> users = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5', 'User 6']; // Simulated user list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0, // Remove the shadow
      ),
      body: Container(
        color: Colors.black, // Set background color to black
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[900], // Set card color to dark grey
              child: ListTile(
                title: Text(
                  users[index],
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.warning, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showWarningDialog(context, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.block, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showBlockDialog(context, index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Color(0xFF039e8e)),
                      onPressed: () {
                        _showDeleteDialog(context, index);
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

  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900], // Set background color to dark grey
          title: Text('Confirmation', style: TextStyle(color: Colors.white)), // Set title text color to white
          content: Text('Voulez-vous vraiment supprimer cet utilisateur?', style: TextStyle(color: Colors.white)), // Set content text color to white
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))), // Set button text color to the reference color
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Color(0xFF039e8e))), // Set button text color to the reference color
              onPressed: () {
                setState(() {
                  users.removeAt(index); // Remove the user from the list
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBlockDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900], // Set background color to dark grey
          title: Text('Confirmation', style: TextStyle(color: Colors.white)), // Set title text color to white
          content: Text('Voulez-vous vraiment bloquer cet utilisateur?', style: TextStyle(color: Colors.white)), // Set content text color to white
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))), // Set button text color to the reference color
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Bloquer', style: TextStyle(color: Color(0xFF039e8e))), // Set button text color to the reference color
              onPressed: () {
                // TODO: Implement block functionality here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showWarningDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900], // Set background color to dark grey
          title: Text('Confirmation', style: TextStyle(color: Colors.white)), // Set title text color to white
          content: Text('Voulez-vous vraiment envoyer un avertissement à cet utilisateur?', style: TextStyle(color: Colors.white)), // Set content text color to white
          actions: <Widget>[
            TextButton(
              child: Text('Annuler', style: TextStyle(color: Color(0xFF039e8e))), // Set button text color to the reference color
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Avertir', style: TextStyle(color: Color(0xFF039e8e))), // Set button text color to the reference color
              onPressed: () {
                // TODO: Implement warning functionality here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
