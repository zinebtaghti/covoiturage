import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC6rdntPjRF9OYFZ_AGIiAtyThkRNdKmyI",
      appId: "1:628850008645:android:0cc434b4ba1b6cf896792c",
      messagingSenderId: "628850008645",
      projectId: "covoiturage-82f8b",
    ),
  )
      : await Firebase.initializeApp();
  runApp(MyApp());
}*/

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
      home: ChatScreen(),
    );
  }
}

class Message {
  String text;
  DateTime time;
  String senderId;
  bool seen;

  Message({required this.text, required this.time, required this.senderId, this.seen = false});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time.toIso8601String(), // Use ISO 8601 format
      'senderId': senderId,
      'seen': seen,
    };
  }

  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
      text: json['text'],
      time: DateTime.parse(json['time']),
      senderId: json['senderId'],
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
  String conductorEmail = "zinebtaghti3@gmail.com";
  String passengerEmail = "younes@gmail.com";

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  void fetchMessages() {
    _databaseReference.child('users').onChildAdded.listen((event) {
      var message = Message.fromJson(event.snapshot.value as Map<dynamic, dynamic>? ?? {});
      setState(() {
        _messages.add(message);
      });
    });
  }

  void sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      var message = Message(text: text, time: DateTime.now(), senderId: conductorEmail, seen: false);
      _databaseReference.child('users').push().set(message.toJson());
      _textController.clear();
    }
  }

  Widget _buildMessageBubble(Message message) {
    bool isConductorMessage = message.senderId == conductorEmail;
    Color? bubbleColor = isConductorMessage ? Color(0xFF039e8e) : Colors.grey[800];
    Color textColor = Colors.white; // Toujours blanc

    return Align(
      alignment: isConductorMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${message.time.hour.toString().padLeft(2, '0')}:${message.time.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.done_all,
                    color: Colors.blue,
                    size: 16.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                hintText: 'Type a message...',
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
        title: Text('Communiquer avec le conducteur'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/image9.png'), // Added background image here
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
            _buildInputArea(),
          ],
        ),
      ),
    );
  }
}