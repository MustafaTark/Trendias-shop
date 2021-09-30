import 'package:flutter/material.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/providers/cart.dart';
import 'package:practice/providers/products.dart';
import 'package:practice/providers/user_details.dart';
import 'package:practice/screens/categories_grid_screen.dart';
import 'package:practice/screens/details_screen.dart';
import 'package:practice/screens/search_screen.dart';
import 'package:practice/widgets/badge.dart';
import 'package:practice/widgets/category_item.dart';
import 'package:practice/widgets/product_item.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

//import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> _categories = ['shirt', 'jacket', 'bag', 'shoes'];
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context).firstElements;
    final cartData = Provider.of<Cart>(context).items;
    final userData = Provider.of<UserDatails>(context).details;
    final auth = Provider.of<Auth>(context, listen: false);
    int quntity = cartData.length;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => DetailsScreen(),
              ),
            );
          },
          child: FutureBuilder(
            future: Future.delayed(Duration.zero, () async {
              await Provider.of<UserDatails>(context, listen: false)
                  .getUserDetails(auth.userId, auth.token);
            }),
            builder: (ctx, snapshot) => CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 6,
              child: Container(
                child: userData.imageUrl.path == ''
                    ? CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[100],
                        backgroundImage: const NetworkImage(
                            'https://sothis.es/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png'),
                      )
                    : CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: FileImage(userData.imageUrl),
                      ),
              ),
            ),
          ),
          // FileImage(userData.imageUrl),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => SearchScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              size: 25,
            ),
          ),
          Badge(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CartScreen(),
                  ),
                );
                print(cartData);
              },
            ),
            value: quntity.toString(),
            color: Colors.redAccent,
          ),
        ],
        elevation: 0.0,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 27,
              ),
              Text(
                'Trendias Shop',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Get populer fashion from here',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CategoriesGridScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 140,
                width: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (ctx, i) => CategoryItem(_categories[i]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => CategoriesGridScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 1), () async {
                  await Provider.of<Products>(context, listen: false)
                      .findFirstElement()
                      .then((value) {
                    setState(() {
                      _isLoading = true;
                    });
                  }).timeout(
                    Duration(seconds: 2),
                  );
                }),
                builder: (ctx, snapshot) => _isLoading
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        padding: const EdgeInsets.only(left: 10),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          addRepaintBoundaries: true,
                          padding: EdgeInsets.only(top: 6),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.height * 0.00055,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 11,
                          ),
                          itemBuilder: (ctx, i) => Container(
                            child: ChangeNotifierProvider.value(
                              value: prodData[i],
                              child: ProductItem(
                                prodData[i].id,
                                prodData[i].title,
                                prodData[i].imageUrl,
                                prodData[i].description,
                                prodData[i].price,
                                prodData[i].isFavorite,
                              ),
                            ),
                          ),
                          itemCount: prodData.length,
                        ),
                      )
                    : Center(
                        child: Container(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
