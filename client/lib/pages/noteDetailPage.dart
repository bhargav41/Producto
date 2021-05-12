import 'package:client/model/note.dart';
import 'package:client/pages/shareNotePage.dart';
import 'package:client/services/noteService.dart';
import 'package:client/services/tokenService.dart';
import 'package:client/widgets/customAppBar.dart';
import 'package:client/widgets/inputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
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
    final _subtitle = TextEditingController(text: widget.note.subtitle);
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.note.title,
      ),
      body: !_isLoading
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: InputField(
                controller: _subtitle,
                label: 'Enter Sub Title',
                minLines: 10,
                maxLines: 10,
              ))
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.save, color: Colors.white),
            title: "Save",
            titleColor: Colors.white,
            subtitle: "Save changes",
            subTitleColor: Colors.white,
            backgroundColor: Colors.black,
            onTap: () async {
              setState(() {
                _isLoading = !_isLoading;
              });
              String result = await NotesService().editNote(
                  title: widget.note.title,
                  subtitle: _subtitle.text,
                  id: widget.note.id);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$result')));
              Navigator.pop(context);
            },
          ),
          MenuItem(
            child: Icon(Icons.share, color: Colors.white),
            title: "Invite",
            titleColor: Colors.white,
            subtitle: "Invite collaborators",
            subTitleColor: Colors.white,
            backgroundColor: Colors.black,
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => ShareNotePage(
                          sharedWith: widget.note.sharedWith,
                          id: widget.note.id,
                        ))),
          ),
          MenuItem(
            child: Icon(Icons.delete_forever, color: Colors.red),
            title: "Delete",
            titleColor: Colors.red,
            subtitle: "Delete Note. (Permanent Action)",
            subTitleColor: Colors.red,
            backgroundColor: Colors.black,
            onTap: () async {
              setState(() {
                _isLoading = !_isLoading;
              });
              String result = await NotesService().deleteNote(
                  token: context.read<TokenService>().token,
                  id: widget.note.id);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$result')));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
