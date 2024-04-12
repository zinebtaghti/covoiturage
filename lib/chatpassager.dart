import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        hintColor: Color(0xFF039e8e),
        scaffoldBackgroundColor: Colors.black, // Defines the background as black for the entire interface
        textTheme: TextTheme( // Adjust the size of the writing
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
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0), // Reduced vertical spacing
      child: Align(
        alignment: Alignment.centerLeft,
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
      body: Column(
        children: [
          SizedBox(height: 20), // Add space at the top
          Text(
            'Communiquer avec le passager',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24, // Adjust the size of the writing
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
