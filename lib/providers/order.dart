import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:practice/providers/cart.dart';

class OrderItem {
  List<CartItem> cartData;
  DateTime orderDate;
  OrderItem({
    required this.cartData,
    required this.orderDate,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  String userId;
  String authToken;
  Order(this.userId, this._orders, this.authToken);
  List<OrderItem> get orders {
    return _orders;
  }

  Future<void> addOrder(List<CartItem> cartData) async {
    final url = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'cartData': cartData
                .map(
                  (e) => {
                    'id': e.id,
                    'title': e.title,
                    'amount': e.amount,
                    'price': e.price,
                    'imageUrl': e.imageUrl,
                    'quntity': e.quntity,
                  },
                )
                .toList(),
            'orderDate': DateTime.now().toIso8601String(),
          },
        ),
      );
      _orders.insert(
        0,
        OrderItem(
          cartData: cartData,
          orderDate: DateTime.now(),
        ),
      );

      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        'https://fashion-app-576aa-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final List<OrderItem> loadedOrder = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>?;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((orderId, orderData) {
        loadedOrder.add(
          OrderItem(
            orderDate: DateTime.parse(orderData['orderDate']),
            cartData: (orderData['cartData'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    quntity: item['quntity'],
                    price: item['price'],
                    amount: item['amount'],
                    imageUrl: item['imageUrl'],
                  ),
                )
                .toList(),
          ),
        );
      });
      _orders = loadedOrder.reversed.toList();
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  double total(int quntity, double price) {
    double total = 0.0;
    total += quntity * price;
    return total;
  }
}
