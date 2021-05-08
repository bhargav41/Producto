import 'package:client/services/noteService.dart';
import 'package:client/services/tokenService.dart';
import 'package:client/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/customAppBar.dart';
import 'package:provider/provider.dart';

class NewNote extends StatefulWidget {
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final title = TextEditingController();
  final subtitle = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Note',
      ),
      body: !_isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InputField(controller: title, label: 'Title'),
                Flexible(
                  flex: 1,
                  child: InputField(
                    controller: subtitle,
                    label: 'Sub Title',
                    minLines: 10,
                    maxLines: 10,
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (title.text.length == 0 || subtitle.text.length == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill all fields')));
          } else {
            setState(() {
              _isLoading = !_isLoading;
            });
            String result = await NotesService().addNote(
                token: context.read<TokenService>().token,
                title: title.text,
                subtitle: subtitle.text);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('$result')));
            Navigator.pop(context);
          }
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
