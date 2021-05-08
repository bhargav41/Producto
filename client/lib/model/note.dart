import 'package:flutter/material.dart';

class Note {
  final String title;
  final String subtitle;
  final String id;
  final bool isShared;
  final List<dynamic> sharedWith;
  final String createdAt;
  Note(
      {@required this.title,
      @required this.subtitle,
      @required this.id,
      @required this.isShared,
      @required this.sharedWith,
      @required this.createdAt});

  factory Note.fromJson({@required Map<String, dynamic> data}) => Note(
      title: data['title'] as String,
      subtitle: data['subtitle'] as String,
      id: data['_id'] as String,
      isShared: data['isShared'] as bool,
      sharedWith: data['sharedWith'] as List<dynamic>,
      createdAt: data['createdAt'] as String);
}
