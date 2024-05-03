import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Communiquer avec le conducteur',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF039e8e),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarTextStyle: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20.0),
          ).bodyText2,
          titleTextStyle: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 20.0),
          ).headline6,
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: ChatScreen(),
    );
  }
}

class Message {
  String text;
  DateTime time;
  bool seen;

  Message({required this.text, required this.time, this.seen = false});

  // Convertir un objet Message en Map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time.toString(), // Convertir la date en string
      'seen': seen
    };
  }

  // Créer un objet Message à partir d'un Map
  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
      text: json['text'],
      time: DateTime.parse(json['time']), // Convertir la date string en DateTime
      seen: json['seen'],
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    fetchMessages(); // Récupérer les messages existants
  }

  // Fonction pour récupérer les messages
  void fetchMessages() {
    _databaseReference.child('users').child('userID').child('messages').onChildAdded.listen((event) {
      var message = Message.fromJson(event.snapshot.value as Map<dynamic, dynamic>);
      setState(() {
        _messages.add(message);
      });
    });
  }

  // Fonction pour envoyer un message
  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      var message = Message(text: text, time: DateTime.now(), seen: true);
      _databaseReference.child('users').child('userID').child('messages').push().set(message.toJson());
      _textController.clear();
    }
  }

  // Construire le widget de bulle de message
  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Color(0xFF039e8e),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Communiquer avec le conducteur'), // Titre de l'AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image9.png'), // Utilisez le bon asset pour votre arrière-plan
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),
            Divider(height: 1.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.black,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    color: Color(0xFF039e8e),
                    onPressed: () {
                      // TODO: Implémenter la fonctionnalité du clavier emoji
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: sendMessage,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Écrire un message...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Color(0xFF039e8e),
                    onPressed: () => sendMessage(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
