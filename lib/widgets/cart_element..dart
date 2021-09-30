import 'package:flutter/material.dart';

class CartElement extends StatelessWidget {
  final String title;
  final int id;
  final String imageUrl;
  final int quntity;
  final double total;

  CartElement({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.quntity,
    required this.total,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.16,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              height: 190,
              width: 140,
            ),
          ),
          Positioned(
            left: 160,
            top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
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
                      quntity.toString(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
