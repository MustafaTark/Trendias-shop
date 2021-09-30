import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/providers/products.dart';
import 'package:practice/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGridScreen extends StatefulWidget {
  final String categoryName;
  ProductsGridScreen(this.categoryName);

  @override
  _ProductsGridScreenState createState() => _ProductsGridScreenState();
}

class _ProductsGridScreenState extends State<ProductsGridScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 1), () async {
          await Provider.of<Products>(context, listen: false)
              .fetchProduct(widget.categoryName)
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
                height: 700,
                padding: EdgeInsets.only(left: 10),
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  addRepaintBoundaries: true,
                  padding: EdgeInsets.only(top: 6),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        MediaQuery.of(context).size.height * 0.0006,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, i) => Container(
                    height: 700,
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
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              ),
      ),
    );

    //);
  }
}
