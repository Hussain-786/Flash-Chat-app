import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'buttons.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Buttons buttons = Buttons();
  String email;
  String password;
  bool showLoad = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showLoad,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                              child: Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('images/logo.png'),
                    width: 150.0,
                    height: 150.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  cursorColor: Colors.lightBlueAccent,
                  onChanged: (value) {
                    email = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: buttons.textFieldDecoration(
                    text: 'Enter Email',
                    colour: Colors.lightBlueAccent,
                  ),
                  style: kTextFieldLogin,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  cursorColor: Colors.lightBlueAccent,
                  onChanged: (value) {
                    password = value;
                  },
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: buttons.textFieldDecoration(
                    text: 'Enter Password',
                    colour: Colors.lightBlueAccent,
                  ),
                  style: kTextFieldLogin,
                ),
              ),
              Buttons(
                onpressed: () async {
                  setState(() {
                    showLoad = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      showLoad = false;
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                colour: Colors.lightBlueAccent,
                text: 'Login',
                textStyle: kButtonTextB,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
