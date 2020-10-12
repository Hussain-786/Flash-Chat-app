import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final Function onpressed;
  final String text;
  final Color colour;
  final TextStyle textStyle;
  Buttons({this.onpressed, this.colour, this.text, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RaisedButton(
        onPressed: onpressed,
        color: colour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13.0),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration({String text, Color colour}) {
    return InputDecoration(
      fillColor: Colors.white,
      labelText: text,
      hintText: text,
      hintStyle: TextStyle(
        fontSize: 16.0,
        color: colour,
      ),
      labelStyle: TextStyle(
        color: colour,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colour,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(54.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colour, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(54.0)),
      ),
    );
  }
}
