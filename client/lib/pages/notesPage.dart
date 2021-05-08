import 'package:client/model/note.dart';
import 'package:client/pages/addNote.dart';
import 'package:client/pages/noteDetailPage.dart';
import 'package:client/pages/settingsScreen.dart';
import 'package:client/pages/todoList.dart';
import 'package:client/services/noteService.dart';
import 'package:client/services/tokenService.dart';
import 'package:client/widgets/noteTile.dart';
import 'package:client/widgets/rootAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future<List<Note>> getAllNotes(BuildContext context) async {
    return NotesService()
        .getAllNotes(token: context.read<TokenService>().token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootAppBar(title: 'Notes'),
      endDrawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.timer),
                title: Text('To Do'),
                onTap: () => Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new TodoPage())),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.assignment),
                title: Text('Assignments'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new SettingsScreen()));
                },
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Note>>(
        future: getAllNotes(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.length != 0) {
              return ListView.builder(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return NoteTile(
                    note: snapshot.data[index],
                    trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new NoteDetailsPage(
                                              note: snapshot.data[index])))
                              .then((value) => setState(() {}));
                        },
                        child: Text(
                          'View Note',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800])),
                  );
                },
              );
            } else {
              return Center(
                child: Text('Nothing to show'),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new NewNote()))
              .then((value) => setState(() {}));
        },
        label: Text('Add Note'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
