import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:practice/models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  late String _userId;
  late DateTime _expiryDate;

  bool _checkAuth = false;
  bool get isAuth {
    return _checkAuth;
  }

  String get token {
    if (_checkAuth) {
      return _token;
    }
    return '';
  }

  String get userId {
    if (_checkAuth) {
      return _userId;
    }
    return '';
  }

  Future<void> _authenticate(
      String email, String password, String typeSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$typeSegment?key=AIzaSyC4FbAKq6F7gJP9eEC2vFItmLliKbGxjvE';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      //print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpExceptions(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _checkAuth = true;
      //print(check);

      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _checkAuth = true;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password, String userName,
      String phoneNumber, String imageUrl) async {
    await Future.delayed(
      Duration(seconds: 1),
      () => _authenticate(email, password, 'signUp'),
    );
    try {
      final url = Uri.parse(
          'https://fashion-app-576aa-default-rtdb.firebaseio.com/users/$userId.json');
      await http.post(
        url,
        body: json.encode(
          {
            'Username': userName,
            'Phone Number': phoneNumber,
            'Email': email,
            'Password': password,
            'imageUrl': '',
          },
        ),
      );
    } catch (err) {
      print(err);
    }
  }

  Future<void> login(String email, String password) async {
    return Future.delayed(Duration(seconds: 1),
        () => _authenticate(email, password, 'signInWithPassword'));
  }

  Future<bool> tryAutoLogin() async {
    return true;
  }
}
