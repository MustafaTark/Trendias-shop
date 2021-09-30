import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:practice/models/product.dart';
//import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> _favoriteItems = [];
  List<Product> _firstElements = [];
  List<Product> _searchedData = [];
  bool check = true;
  List<Product> get items {
    return _items;
  }

  List<Product> get favoriteItems {
    return _favoriteItems;
  }

  List<Product> get firstElements {
    return _firstElements;
  }

  List<Product> get searchedData {
    return _searchedData;
  }

  late String userId;
  late String authToken;
  Products(this.userId, this._items, this.authToken);
  Future<void> fetchProduct(String gender) async {
    var url = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          'https://fashion-app-576aa-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      List<Product> loadedProduct = [];
      responseData.forEach(
        (prodId, prodValue) => loadedProduct.add(
          Product(
            id: prodValue['id'],
            title: prodId,
            description: prodValue['description'],
            gender: prodValue['gender'],
            imageUrl: prodValue['imageUrl'],
            price: prodValue['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
            //loadedProduct[prodValue['id']].isFavorite,
          ),
        ),
      );

      _items =
          loadedProduct.where((element) => gender == element.gender).toList();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> favoriteProducts() async {
    var url = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          'https://fashion-app-576aa-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      List<Product> loaded = [];
      responseData.forEach(
        (prodId, prodValue) => loaded.add(
          Product(
            id: prodValue['id'],
            title: prodValue['title'],
            description: prodValue['description'],
            gender: prodValue['gender'],
            imageUrl: prodValue['imageUrl'],
            price: prodValue['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        ),
      );

      _favoriteItems = loaded.where((element) => element.isFavorite).toList();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Product findById(int id) {
    return _items.firstWhere(
      (prod) => prod.id == id,
      orElse: () => Product(
          id: 0,
          title: '',
          description: '',
          price: 0,
          imageUrl: '',
          gender: '',
          isFavorite: false),
    );
    // ignore: dead_code
    notifyListeners();
  }

  Future<void> findFirstElement() async {
    var url = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          'https://fashion-app-576aa-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      List<Product> loadedFirst = [];
      responseData.forEach(
        (prodId, prodValue) => loadedFirst.add(
          Product(
            id: prodValue['id'],
            title: prodValue['title'],
            description: prodValue['description'],
            gender: prodValue['gender'],
            imageUrl: prodValue['imageUrl'],
            price: prodValue['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        ),
      );

      _firstElements = loadedFirst.where((element) => element.id == 0).toList();
    } catch (err) {
      print(err);
    }
  }

  Future<void> fetchSearchedData(String searched) async {
    var url = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      url = Uri.parse(
          'https://fashion-app-576aa-default-rtdb.firebaseio.com/userFavorite/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      List<Product> loadedSearched = [];
      responseData.forEach(
        (prodId, prodValue) => loadedSearched.add(
          Product(
            id: prodValue['id'],
            title: prodValue['title'],
            description: prodValue['description'],
            gender: prodValue['gender'],
            imageUrl: prodValue['imageUrl'],
            price: prodValue['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        ),
      );
      if (searched.isEmpty) {
        return;
      }
      _searchedData = loadedSearched
          .where(
            (element) =>
                (element.title.toLowerCase())
                    .contains(searched.toLowerCase()) ||
                (element.description.toLowerCase())
                    .contains(searched.toLowerCase()) ||
                (element.gender.toLowerCase()).contains(searched.toLowerCase()),
          )
          .toList();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
