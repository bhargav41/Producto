import 'package:flutter/material.dart';

class RootAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget> trailing;
  RootAppBar({@required this.title, this.trailing});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: trailing,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
