import 'package:flutter/material.dart';
import 'constants.dart';
import 'buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  cursorColor: Colors.black54,
                  onChanged: (value) {
                    email = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: buttons.textFieldDecoration(
                    text: 'Enter Email',
                    colour: Colors.black54,
                  ),
                  style: kTextFieldRegister,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  cursorColor: Colors.black54,
                  onChanged: (value) {
                    password = value;
                  },
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: buttons.textFieldDecoration(
                    text: 'Enter Password',
                    colour: Colors.black54,
                  ),
                  style: kTextFieldRegister,
                ),
              ),
              Buttons(
                onpressed: () async {
                  setState(() {
                    showLoad = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      showLoad = false;
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                colour: Colors.white,
                text: 'Register',
                textStyle: kButtonTextW,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
