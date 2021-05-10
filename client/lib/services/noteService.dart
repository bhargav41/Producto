import 'dart:convert';

import 'package:client/constants.dart';
import 'package:client/model/note.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class NotesService {
  Future<List<Note>> getAllNotes({@required String token}) async {
    http.Response response = await http.get(api('/notes/all'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });
    Map<String, dynamic> body = jsonDecode(response.body);
    developer.log('$body', name: 'NoteService');
    if (response.statusCode == 200) {
      List<Note> result = [];
      for (Map<String, dynamic> note in body['notes']) {
        result.add(Note.fromJson(data: note));
      }
      return result;
    } else {
      return [];
    }
  }

  Future<String> addNote(
      {@required String token, @required String title, String subtitle}) async {
    http.Response response = await http.post(api('/notes/add'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'title': '$title', 'subtitle': '$subtitle'}));
    Map<String, dynamic> body = jsonDecode(response.body);
    developer.log('$body', name: 'NoteService');
    if (response.statusCode == 201) {
      return body['message'];
    } else {
      return body['message'] ?? 'An unexpected error occured';
    }
  }

  Future<String> deleteNote(
      {@required String token, @required String id}) async {
    http.Response response = await http.post(api('/notes/delete'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'id': id}));
    Map<String, dynamic> body = jsonDecode(response.body);
    developer.log('$body', name: 'NoteService');
    if (response.statusCode == 201) {
      return body['message'];
    } else {
      return body['message'] ?? 'An unexpected error occured';
    }
  }

  Future<String> shareNote(
      {@required String token,
      @required List<dynamic> emails,
      @required String id}) async {
    http.Response response = await http.post(api('/notes/share'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({'emails': emails, 'id': id}));
    Map<String, dynamic> body = jsonDecode(response.body);
    developer.log('$body', name: 'NoteService');
    if (response.statusCode == 201) {
      return body['message'];
    } else {
      return body['message'] ?? 'An unexpected error occured';
    }
  }
}
