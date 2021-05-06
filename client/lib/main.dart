import 'package:client/pages/blankPage.dart';
import 'package:client/pages/loginPage.dart';
import 'package:client/pages/notesPage.dart';
import 'package:client/services/tokenService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context) => TokenService())
  ], child: Producto()));
}

class Producto extends StatefulWidget {
  @override
  _ProductoState createState() => _ProductoState();
}

class _ProductoState extends State<Producto> {
  _tokenStatus(BuildContext context) async {
    return context.watch<TokenService>().verifyToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Producto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.black,
          accentColor: Colors.black),
      home: FutureBuilder(
          future: _tokenStatus(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return BlankPapge();
            } else {
              developer.log('${snapshot.data}', name: 'Main');
              if (snapshot.data == true) {
                return NotesPage();
              } else {
                return LoginPage();
              }
            }
          }),
    );
  }
}
