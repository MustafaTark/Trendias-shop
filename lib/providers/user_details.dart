import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User {
  String username;
  String phoneNumber;
  String email;
  File imageUrl;
  String address;
  User({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
    required this.address,
  });
}

class UserDatails with ChangeNotifier {
  User _details = User(
      username: '',
      email: '',
      phoneNumber: '',
      imageUrl: File(''),
      address: '');
  User get details {
    return _details;
  }

  Future<void> getUserDetails(String userId, String authToken) async {
    final url1 = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/users/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url1);
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      final url2 = Uri.parse(
          'https://fashion-app-576aa-default-rtdb.firebaseio.com/newUsersData/$userId.json?auth=$authToken');
      final newResponse = await http.get(url2);
      final newData = json.decode(newResponse.body);
      extractedData!.forEach(
        (key, value) => _details = User(
          username:
              //value['Username'],
              newData['Username'] == null
                  ? value['Username']
                  : newData['Username'],
          email:
              //value['Email'],
              newData['Email'] == null ? value['Email'] : newData['Email'],
          phoneNumber:

              //value['Phone Number'],
              newData['Phone Number'] == null
                  ? value['Phone Number']
                  : newData['Phone Number'],
          imageUrl:
              //value['imageUrl'],
              newData['imageUrl'] == null
                  ? File(value['imageUrl'])
                  : File(newData['imageUrl']),
          address: '',
        ),
      );
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> updataUserData(
      String label, String newData, String userId, String authToken) async {
    final url1 = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/newUsersData/$userId.json?auth=$authToken');
    final url2 = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyC4FbAKq6F7gJP9eEC2vFItmLliKbGxjvE');
    try {
      await http.patch(
        url1,
        body: json.encode({
          label: newData,
        }),
      );
      if (label.contains('mail')) {
        await http.post(
          url2,
          body: json.encode({
            'idToken': authToken,
            'email': newData,
            'returnSecureToken': true,
          }),
        );
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
