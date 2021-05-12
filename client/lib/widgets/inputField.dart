import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final bool obscured;
  final int minLines;
  final int maxLines;
  InputField(
      {@required this.controller,
      @required this.label,
      this.type = TextInputType.text,
      this.obscured = false,
      this.minLines = 1,
      this.maxLines = 1});
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,
        keyboardType: widget.type,
        obscureText: widget.obscured,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
