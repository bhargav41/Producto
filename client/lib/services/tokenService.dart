import 'dart:convert';

import 'package:client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class TokenService with ChangeNotifier, DiagnosticableTreeMixin {
  String _token;
  String get token => _token;

  Future<void> setToken({@required String token}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _token = token;
    developer.log('$_token', name: 'TokenService');
    await _prefs.setString('token', token);
  }

  Future<void> deleteToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _token = null;
    await _prefs.clear();
  }

  Future<bool> verifyToken() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _token = _prefs.getString('token');
      if (_token != null) {
        http.Response response = await http.post(api('/auth/validate'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({'token': '$_token'}));
        developer.log('${response.statusCode} : ${response.body}',
            name: 'Verify Token');
        if (response.statusCode == 200) {
          return jsonDecode(response.body)['message'];
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('token', 1));
  }
}
