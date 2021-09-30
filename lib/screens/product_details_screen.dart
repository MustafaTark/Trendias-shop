import 'package:flutter/material.dart';
import 'package:practice/models/product.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/providers/cart.dart';
import 'package:practice/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final bool isFavorite;
  ProductDetailsScreen(this.id, this.title, this.description, this.imageUrl,
      this.price, this.isFavorite);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int counter = 1;
  void _addQuntity() {
    setState(() {
      counter++;
    });
  }

  void _subtructQuntity() {
    setState(() {
      if (counter > 1) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Product>(context);
    final product = Provider.of<Products>(context).findById(widget.id);
    final auth = Provider.of<Auth>(context);
    final total = Provider.of<Cart>(context).total(counter, widget.price);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).backgroundColor,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Theme.of(context).backgroundColor,
                child: IconButton(
                  onPressed: () {
                    prodData.toggel(product.title, auth.userId, auth.token);
                  },
                  icon: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 400,
                width: double.infinity,
                child: Hero(
                  tag: widget.id,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '${widget.title}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    //textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.067,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Qty',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: _subtructQuntity,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                '-',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          counter.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: _addQuntity,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Provider.of<Cart>(context, listen: false).addToCart(
            widget.id,
            counter,
            widget.price,
            total,
            widget.title,
            widget.imageUrl,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Container(
            width: 500,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Add To Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
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
