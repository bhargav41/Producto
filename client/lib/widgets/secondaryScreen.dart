import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  SecondaryButton({@required this.text, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        '$text',
        style: TextStyle(color: Colors.black),
      ),
      style: TextButton.styleFrom(shadowColor: Colors.black),
    );
  }
}
