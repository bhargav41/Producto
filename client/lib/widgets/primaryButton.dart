import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  PrimaryButton({@required this.text, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text('$text'),
        style: ElevatedButton.styleFrom(primary: Colors.black));
  }
}
