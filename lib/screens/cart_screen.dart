import 'package:flutter/material.dart';
import 'package:practice/providers/cart.dart';
import 'package:practice/screens/checkout_screen.dart';
import 'package:practice/widgets/cart_element..dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context).items;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: cartData.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(
                top: 200,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Theme.of(context).accentColor,
                      size: 60,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Shopping Bag Is Empty',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Looks like you haven\'t added any item to your cart yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: cartData.length,
              itemBuilder: (ctx, i) => Container(
                height: MediaQuery.of(context).size.height * 0.23,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CartElement(
                    id: cartData[i].id,
                    title: cartData[i].title,
                    imageUrl: cartData[i].imageUrl,
                    quntity: cartData[i].quntity,
                    total: cartData[i].amount,
                  ),
                ),
              ),
            ),
      bottomNavigationBar: cartData.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CheckoutScreen(
                      cartData.firstWhere(
                        (element) => element.id <= 100,
                      ),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
