import 'package:client/pages/loginPage.dart';
import 'package:client/services/tokenService.dart';
import 'package:client/widgets/rootAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppBar(title: 'Settings'),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.clear_outlined),
            title: Text('Delete all data'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () async {
              await context.read<TokenService>().deleteToken();
              Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginPage()));
            },
          )
        ],
      ),
    );
  }
}
