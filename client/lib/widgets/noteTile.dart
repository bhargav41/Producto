import 'package:client/model/note.dart';
import 'package:client/pages/noteDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final ElevatedButton trailing;
  int timestamp;
  NoteTile({@required this.note, @required this.trailing}) {
    this.timestamp = int.tryParse(note.createdAt);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadiusDirectional.circular(15.0)),
        child: ListTile(
            title: Text(
              '${note.title}',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            ),
            subtitle: Text(
                'Created ${Jiffy(Jiffy.unix(timestamp).format()).fromNow()}'),
            trailing: trailing),
      ),
    );
  }
}
