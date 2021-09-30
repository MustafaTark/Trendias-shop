import 'package:flutter/material.dart';
import 'package:practice/providers/products.dart';
import 'package:practice/widgets/product_item.dart';
import 'package:provider/provider.dart';
//import 'package:practice/widgets/home.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context).favoriteItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Products'),
        centerTitle: true,
        leading: Container(),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration.zero, () async {
          await Provider.of<Products>(context, listen: false)
              .favoriteProducts()
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
                padding: const EdgeInsets.only(left: 10),
                child: prodData.isEmpty
                    ? Center(
                        child: Text('No item added'),
                      )
                    : GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        addRepaintBoundaries: true,
                        padding: const EdgeInsets.only(top: 6),
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
  }
}
