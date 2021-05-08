import 'package:client/model/note.dart';
import 'package:client/services/noteService.dart';
import 'package:client/services/tokenService.dart';
import 'package:client/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteDetailsPage extends StatefulWidget {
  final Note note;
  NoteDetailsPage({@required this.note});
  @override
  _NoteDetailsPageState createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.note.title,
        trailing: [IconButton(icon: Icon(Icons.share), onPressed: () {})],
      ),
      body: !_isLoading
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(widget.note.subtitle.length != null
                  ? widget.note.subtitle
                  : 'No Subtitle was provided'),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          setState(() {
            _isLoading = !_isLoading;
          });
          String result = await NotesService().deleteNote(
              token: context.read<TokenService>().token, id: widget.note.id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$result')));
          Navigator.pop(context);
        },
        label: Text('Delete'),
        icon: Icon(
          Icons.delete_forever,
        ),
      ),
    );
  }
}
