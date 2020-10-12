import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';
import 'constants.dart';
import 'registration_screen.dart';
import 'buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(
        milliseconds: 800,
      ),
      vsync: this,
      upperBound: 80,
    );
    animation = ColorTween(begin: Colors.lightBlueAccent, end: Colors.white).animate(animationController);
    animationController.forward();
    animationController.addListener((){
      setState(() {
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Padding(
                    padding: EdgeInsets.only(left:15.0),
                    child: Image(
                      image: AssetImage('images/logo.png'),
                      width: animationController.value,
                      height: animationController.value,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TypewriterAnimatedTextKit(
                    text: [
                      'Flash Chat',
                    ],
                    textStyle: kText,
                    speed: Duration(milliseconds: 800),
                  ),
                ),
              ],
            ),
            Buttons(
              onpressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              colour: Colors.white,
              text: 'Register',
              textStyle: kButtonTextW,
            ),
            SizedBox(
              width: 50.0,
            ),
            Buttons(
              onpressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
              colour: Colors.lightBlueAccent,
              text: 'Login',
              textStyle: kButtonTextB,
            ),
          ],
        ),
      ),
    );
  }
}