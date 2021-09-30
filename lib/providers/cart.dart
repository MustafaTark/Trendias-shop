import 'package:flutter/cupertino.dart';

class CartItem {
  int id;
  int quntity;
  double price;
  double amount;
  String title;
  String imageUrl;
  CartItem({
    required this.id,
    required this.quntity,
    required this.price,
    required this.amount,
    required this.title,
    required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];
  List<CartItem> get items {
    return _items;
  }

  void addToCart(
    int id,
    int quntity,
    double price,
    double amount,
    String title,
    String imageUrl,
  ) {
    _items.add(
      CartItem(
        id: id,
        quntity: quntity,
        price: price,
        amount: amount,
        title: title,
        imageUrl: imageUrl,
      ),
    );
  }

  double total(int quntity, double price) {
    double total = 0.0;
    total += quntity * price;
    return total;
  }

  CartItem findElement(int id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
