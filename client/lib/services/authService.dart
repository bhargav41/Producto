import 'dart:convert';
import 'dart:developer' as developer;
import 'package:client/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<AuthResult> loginUser(
      {@required String email, @required String password}) async {
    developer.log('$email : $password', name: 'AuthService');
    http.Response response = await http.post(api('/auth/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}));
    developer.log('Response : ${response.body}', name: 'AuthService');
    if (response.statusCode == 200) {
      return AuthResult(
          message: jsonDecode(response.body)['message'],
          status: response.statusCode,
          token: jsonDecode(response.body)['token']);
    } else {
      return AuthResult(
        message: jsonDecode(response.body)['message'],
        status: response.statusCode,
      );
    }
  }

  Future<AuthResult> signUpUser(
      {@required String email, @required String password}) async {
    developer.log('$email : $password', name: 'AuthService');
    http.Response response = await http.post(api('/auth/signup'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'password': password}));
    developer.log('Response : ${response.body}', name: 'AuthService');
    if (response.statusCode == 200) {
      return AuthResult(
          message: jsonDecode(response.body)['message'],
          status: response.statusCode,
          token: jsonDecode(response.body)['token']);
    } else {
      return AuthResult(
          message: jsonDecode(response.body)['message'],
          status: response.statusCode);
    }
  }
}

class AuthResult {
  final String message;
  final int status;
  final String token;
  AuthResult({@required this.message, @required this.status, this.token});
}
