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
          toolbarTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: ChatScreenp(),
    );
  }
}

class Message {
  String text;
  DateTime time;
  String senderId;
  bool seen;

  // Ajouter l'ID de l'expéditeur

  Message({required this.text, required this.time, this.senderId = 'zinebtaghti3@gmail.com', this.seen=false}); // Définir senderId par défaut

  // Convertir un objet Message en Map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time.toString(), // Convertir la date en string
      'senderId': senderId, // Ajouter l'ID de l'expéditeur
      'seen': seen,
    };
  }

  // Créer un objet Message à partir d'un Map
  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
      text: json['text'],
      time: DateTime.parse(json['time']), // Convertir la date string en DateTime
      senderId: json['senderId'], // Récupérer l'ID de l'expéditeur
    );
  }
}

class ChatScreenp extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenp> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  String passagerEmail = "younes@gmail.com"; // L'email du passager

  @override
  void initState() {
    super.initState();
    fetchMessages(); // Récupérer les messages existants
  }

  // Fonction pour récupérer les messages
  void fetchMessages() {
    _databaseReference.child('users').child(passagerEmail.replaceAll('.', '')).child('messages').onChildAdded.listen((event) {
      var message = Message.fromJson(event.snapshot.value as Map<dynamic, dynamic>);
      setState(() {
        _messages.add(message);
      });
    });
    _databaseReference.child('users').child('zinebtaghti3@gmail.com').child('messages').onChildAdded.listen((event) {
      var message = Message.fromJson(event.snapshot.value as Map<dynamic, dynamic>);
      setState(() {
        _messages.add(message);
      });
    });
  }

  // Fonction pour envoyer un message
  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      var message = Message(text: text, time: DateTime.now(), senderId: 'zinebtaghti3@gmail.com');
      _databaseReference.child('users').child(passagerEmail.replaceAll('.', '')).child('messages').push().set(message.toJson());
      _textController.clear();
    }
  }

  // Construire le widget de bulle de message
  Widget _buildMessageBubble(Message message) {
    bool isConductorMessage = message.senderId == passagerEmail;

    return Align(
      alignment: isConductorMessage ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isConductorMessage ? Colors.grey[800] : Color(0xFF039e8e) ,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  message.text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10.0),
              Text(
                '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(width: 4.0),
              _buildMessageStatus(message),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageStatus(Message message) {
    return Icon(
      message.seen ? Icons.done_all : Icons.check,
      size: 16,
      color: message.seen ? Colors.blue : Colors.white,
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.black,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            color: const Color(0xFF039e8e),
            onPressed: () {
              // Implement emoji keyboard functionality
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: sendMessage,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Écrire un message...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: const Color(0xFF039e8e),
            onPressed: () => sendMessage(_textController.text),
          ),
        ],
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
        decoration: const BoxDecoration(
          color: Colors.black,  // Set background color to black
          // image: DecorationImage(
          //   image: AssetImage('assets/image9.png'),
          //   fit: BoxFit.cover,
          // ),
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
            const Divider(height: 1.0),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }
}
