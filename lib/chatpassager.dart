import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Communiquer avec le passager',
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
        _messages.add(Message(text: text, time: DateTime.now(), seen: true)); // Add to the end of the list
      });
      _textController.clear();
    }
  }

  Widget _buildMessageStatus(Message message) {
    return Icon(
      message.seen ? Icons.done_all : Icons.check,
      size: 16,
      color: message.seen ? Colors.blue : Colors.white,
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: Alignment.centerRight, // Change to Alignment.centerLeft for incoming messages
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
                  _buildMessageStatus(message),
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
        title: Text('Communiquer avec le passager'), // AppBar title
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image9.png'), // Use the correct asset for your background
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
                      // TODO: Implement emoji keyboard functionality
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: _sendMessage,
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
