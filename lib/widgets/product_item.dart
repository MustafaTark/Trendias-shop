import 'package:flutter/material.dart';
import 'package:practice/models/product.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/providers/products.dart';
import 'package:practice/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final bool isFavorite;
  ProductItem(this.id, this.title, this.imageUrl, this.description, this.price,
      this.isFavorite);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context).findById(id);
    final prodData = Provider.of<Product>(context);
    final auth = Provider.of<Auth>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider.value(
              value: Product(
                id: prodData.id,
                title: product.title,
                description: product.description,
                gender: product.gender,
                imageUrl: product.imageUrl,
                price: product.price,
                isFavorite: product.isFavorite,
              ),
              child: ProductDetailsScreen(
                id,
                title,
                description,
                imageUrl,
                price,
                isFavorite,
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    imageUrl,
                    width: 170,
                    height: 310,
                  ),
                  Positioned(
                    top: 220,
                    left: 124,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).backgroundColor,
                      child: IconButton(
                        onPressed: () {
                          prodData.toggel(title, auth.userId, auth.token);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                '\$$price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
