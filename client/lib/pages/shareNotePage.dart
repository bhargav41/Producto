import 'package:client/services/noteService.dart';
import 'package:client/services/tokenService.dart';
import 'package:client/widgets/customAppBar.dart';
import 'package:client/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShareNotePage extends StatefulWidget {
  final List<dynamic> sharedWith;
  final String id;
  ShareNotePage({@required this.sharedWith, @required this.id});
  @override
  _ShareNotePageState createState() => _ShareNotePageState();
}

class _ShareNotePageState extends State<ShareNotePage> {
  bool _isLoading = false;
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Collaborators'),
      body: !_isLoading
          ? ListView.builder(
              itemCount: widget.sharedWith.length + 1,
              itemBuilder: (context, index) {
                if (index == widget.sharedWith.length) {
                  return ListTile(
                    title: InputField(
                      controller: email,
                      label: 'Add Email',
                      type: TextInputType.emailAddress,
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          RegExp regex =
                              RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$");
                          if (email.text.length != 0 &&
                              widget.sharedWith.contains(email.text) == false &&
                              regex.allMatches(email.text).length > 0) {
                            setState(() {
                              widget.sharedWith.add(email.text);
                            });
                          }
                        }),
                  );
                } else {
                  return ListTile(
                    title: Text('${widget.sharedWith[index]}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.sharedWith.removeAt(index);
                        });
                      },
                    ),
                  );
                }
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          setState(() {
            _isLoading = !_isLoading;
          });
          String result = await NotesService().shareNote(
              token: context.read<TokenService>().token,
              emails: widget.sharedWith,
              id: widget.id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$result')));
          int i = 0;
          Navigator.popUntil(context, (route) => i++ == 2);
        },
        label: Text('Invite'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
