import 'package:flutter/material.dart';

import 'package:practice/providers/order.dart';

class OrderElement extends StatelessWidget {
  final OrderItem orderData;
  final DateTime date;
  OrderElement({
    required this.orderData,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: orderData.cartData
                .map(
                  (e) => Stack(
                    children: [
                      Positioned(
                        left: 4,
                        top: 4,
                        child: Column(
                          children: [
                            Text(
                              'Trendias Shop',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              date.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 70,
                        bottom: 60,
                        left: 0,
                        right: 0.0,
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                left: 10,
                                top: 10,
                                child: Image.network(
                                  e.imageUrl,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 130,
                                child: Text(
                                  e.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 130,
                                top: 35,
                                child: Row(
                                  children: [
                                    Text(
                                      'Qty',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      e.quntity.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 130,
                                top: 70,
                                child: Text(
                                  '\$${e.price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 70,
                                right: 10,
                                child: Text(
                                  '\$${e.quntity} items',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 8,
                        child: Column(
                          children: [
                            Text(
                              'Total Payment',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '\$${e.amount}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
