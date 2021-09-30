import 'package:flutter/material.dart';
import 'package:practice/providers/order.dart';
import 'package:practice/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 1), () async {
          await Provider.of<Order>(context, listen: false).fetchOrders();
        }),
        builder: (ctx, snapshot) => SizedBox(
          height: double.infinity,
          child: ListView.builder(
            itemCount: orderData.length,
            itemBuilder: (ctx, i) => OrderElement(
              orderData: orderData[i],
              date: orderData[i].orderDate,
            ),
          ),
        ),
      ),
    );
  }
}
