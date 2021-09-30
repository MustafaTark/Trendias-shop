import 'package:flutter/material.dart';
import 'package:practice/providers/products.dart';
import 'package:practice/widgets/product_item.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool notFound = false;
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prodData = Provider.of<Products>(context).searchedData;
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Any thing here',
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
            ),
            icon: Icon(
              Icons.search,
              color: _focusNodes[0].hasFocus
                  ? Theme.of(context).accentColor
                  : Theme.of(context).iconTheme.color,
            ),
          ),
          onFieldSubmitted: (value) async {
            await Future.delayed(Duration(seconds: 1), () async {
              await Provider.of<Products>(context, listen: false)
                  .fetchSearchedData(value);
            });
            setState(() {
              notFound = true;
            });
          },
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            prodData.clear();
          },
        ),
      ),
      body: !notFound
          ? Container()
          : (notFound && prodData.isEmpty)
              ? Center(
                  child: Text('No Results Founded'),
                )
              : GridView.builder(
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
    );
  }
}
