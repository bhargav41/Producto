import 'package:client/pages/loginPage.dart';
import 'package:client/pages/notesPage.dart';
import 'package:client/services/authService.dart';
import 'package:client/services/tokenService.dart';
import 'package:client/widgets/rootAppBar.dart';
import 'package:client/widgets/inputField.dart';
import 'package:client/widgets/primaryButton.dart';
import 'package:client/widgets/secondaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _loading = false;
  final email = TextEditingController();
  final password = TextEditingController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: RootAppBar(title: 'Sign Up'),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                InputField(controller: email, label: 'Email'),
                InputField(
                  controller: password,
                  label: 'Password',
                  obscured: true,
                ),
                Center(
                  child: PrimaryButton(
                    text: 'Sign Up',
                    onPressed: () async {
                      if (email.text.length == 0 || password.text.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all fields')));
                      } else {
                        setState(() {
                          _loading = true;
                        });
                        AuthResult result = await AuthService().signUpUser(
                            email: email.text, password: password.text);
                        setState(() {
                          _loading = false;
                        });
                        if (result.status == 200) {
                          await context
                              .read<TokenService>()
                              .setToken(token: result.token);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Welcome ${email.text}')));
                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new NotesPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${result.message}')));
                        }
                      }
                    },
                  ),
                ),
                Center(
                  child: SecondaryButton(
                    text: 'Log In',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new LoginPage()));
                    },
                  ),
                )
              ],
            ),
    );
  }
}
