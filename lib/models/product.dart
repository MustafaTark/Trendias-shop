import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final String gender;
  final String imageUrl;
  final double price;
  bool isFavorite = false;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.gender,
    required this.imageUrl,
    required this.price,
    required this.isFavorite,
  });
  // void _setFavValue(bool newValue) {
  //   isFavorite = newValue;
  // }

  Future<void> toggel(String favTitle, String userId, String authToken) async {
    final url = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken');

    try {
      http.patch(
        url,
        body: json.encode({
          title: !isFavorite,
        }),
      );
    } catch (err) {
      print(err);
    }
    //print(response.body);
    notifyListeners();
  }

  // Future<void> toggleFavoriteStatus(String token, String userId) async {
  //   //final oldStatus = isFavorite;
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  //   // final url =
  //   //     'https://shop-app-589fd-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json';
  //   // try {
  //   //   final response = await http.put(
  //   //     Uri.parse(url),
  //   //     body: json.encode(
  //   //       isFavorite,
  //   //     ),
  //   //   );
  //   //   if (response.statusCode > 400) {
  //   //     _setFavValue(oldStatus);
  //   //   }
  //   // } catch (error) {
  //   //   _setFavValue(oldStatus);
  //   //   notifyListeners();
  //   // }
  //   //notifyListeners();
  // }
}
