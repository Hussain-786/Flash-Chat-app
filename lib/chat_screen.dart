import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'buttons.dart';
import 'login_screen.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Buttons buttons = Buttons();
  final _auth = FirebaseAuth.instance;
  
  String msg;
  String email;
  final textcontroller = TextEditingController();


  @override
  void initState() {
    super.initState();
    getRegistered();
  }

  void getRegistered() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamMessages(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textcontroller,
                      onChanged: (value) {
                        msg = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type your message here...',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      ),
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      textcontroller.clear();
                      await _firestore.collection('messages').add({
                        'sender': loggedInUser.email,
                        'text': msg,
                      });
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 15.0,
                      ),
                    ),
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

class StreamMessages extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> textWidgets = [];
        for (var message in messages) {
          final text = message.data['text'];
          final sender = message.data['sender'];
          final currentUser = loggedInUser.email;
          final messageBubble =
              MessageBubble(sender: sender, text: text, isMe: currentUser == sender);
          textWidgets.add(messageBubble);
        }
        return Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              reverse: true,
              children: textWidgets,
              ),
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final sender;
  final text;
  bool isMe;
  MessageBubble({this.sender, this.text,this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.0),
            child: Text(
              sender,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13.0,
              ),
            ),
          ),
          Material(
            borderRadius: isMe ? BorderRadius.only(
              topLeft: Radius.circular(25.0),
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
              ) : BorderRadius.only(topRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
              ),
            elevation: 7.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
