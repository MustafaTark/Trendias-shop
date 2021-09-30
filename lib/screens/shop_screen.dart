import 'package:flutter/material.dart';
import 'package:practice/widgets/category_item.dart';
//import 'package:practice/widgets/home.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> men = [
      'shirt',
      'jacket',
      'bag',
      'shoes',
      'men\'s trouseres',
      'hat',
    ];
    List<String> women = [
      'women\'s trouseres',
      'blouse',
      'dresses',
      'flat shoeses',
    ];
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text('Categories'),
          elevation: 0.0,
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Men',
              ),
              Tab(
                text: 'Women',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoryGender(men),
            CategoryGender(women),
          ],
        ),
      ),
    );
  }
}

class CategoryGender extends StatelessWidget {
  final List<String> gender;
  CategoryGender(this.gender);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => CategoryItem(gender[i]),
      itemCount: gender.length,
    );
  }
}
