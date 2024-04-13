import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Communiquer avec le passager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        hintColor: Color(0xFF039e8e),
        scaffoldBackgroundColor: Colors.black, // Définit le fond en noir pour toute l'interface
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
          bodyText2: TextStyle(color: Colors.white), // Style de texte par défaut
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
        _messages.add(Message(text: text, seen: true)); // Add to the end of the list
      });
      _textController.clear();
    }
  }

  Widget _buildMessageStatus(Message message) {
    return Container(
      height: 16, // Restrict the container height
      child: Stack(
        children: [
          Icon(
            Icons.check,
            size: 16,
            color: message.seen ? Colors.blue : Colors.white,
          ),
          Positioned(
            left: 6, // Move the second check to the right
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
        title: Text('Communiquer avec le passager'), // Titre de l'appbar
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Add space at the top
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
                    // TODO: Implement emoji keyboard functionality
                  },
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
    );
  }
}
