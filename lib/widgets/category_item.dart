import 'package:flutter/material.dart';

import 'package:practice/screens/products_grid_screen.dart';

class CategoryItem extends StatelessWidget {
  final String category;
  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ProductsGridScreen(category),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 70,
          width: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              category,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
