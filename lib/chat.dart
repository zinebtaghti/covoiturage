import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        hintColor: Color(0xFF039e8e),
        scaffoldBackgroundColor: Colors.transparent, // Rend le fond transparent pour laisser voir l'image
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 18.0),
        ),
      ),
      home: ChatScreen(),
    );
  }
}

class Message {
  String text;
  bool seen;

  Message({required this.text, this.seen = false});
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> _messages = [];

  void _sendMessage(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        _messages.insert(0, Message(text: text, seen: true));
      });
      _textController.clear();
    }
  }

  Widget _buildMessageStatus(Message message) {
    return Container(
      height: 16,
      child: Stack(
        children: [
          Icon(
            Icons.check,
            size: 16,
            color: message.seen ? Colors.blue : Colors.white,
          ),
          Positioned(
            left: 6,
            child: Icon(
              Icons.check,
              size: 16,
              color: message.seen ? Colors.blue : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Color(0xFF039e8e),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 5),
            _buildMessageStatus(message),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image6.png"), // Assurez-vous que le chemin vers l'image est correct
            fit: BoxFit.cover, // Couvre tout l'espace disponible
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Communiquer avec le conducteur',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              color: Colors.black.withOpacity(0.5), // Légère transparence pour voir le fond
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    color: Color(0xFF039e8e),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: _sendMessage,
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
                    onPressed: () => _sendMessage(_textController.text),
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
