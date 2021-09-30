import 'package:flutter/material.dart';
import 'package:practice/widgets/category_item.dart';

class CategoriesGridScreen extends StatelessWidget {
  final List<String> category = [
    'shirt',
    'jacket',
    'bag',
    'shoes',
    'men\'s trouseres',
    'women\'s trouseres',
    'blouse',
    'dresses',
    'flat shoeses',
    'hat',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (ctx, i) => CategoryItem(category[i]),
        itemCount: category.length,
      ),
    );
  }
}
