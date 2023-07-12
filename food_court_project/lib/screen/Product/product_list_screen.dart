import 'dart:convert';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

import 'package:flutter/material.dart';
import 'package:food_court_project/components/color.dart';
import 'package:food_court_project/constants.dart';
import 'package:food_court_project/models/product.dart';
import 'package:food_court_project/screen/Product/add_product_screen.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> _items = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    try {
      final response = await http
          .get(uri("Product/GetAllProducts/"))
          .timeout(defaultTimeout);
      print(response.statusCode);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
        });
      }
      final json = jsonDecode(response.body) as Map;
      if (json["result"] == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final List<Product> loadedItems = [];
      for (final item in json["result"]["items"]) {
        loadedItems.add(
          convertProduct(item),
        );
      }
      setState(() {
        _items = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! Please try again later.';
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _loadItems();
    });
  }

  // void _removeItem(GroceryItem item) async {
  //   final index = _groceryItems.indexOf(item);
  //   setState(() {
  //     _groceryItems.remove(item);
  //   });

  //   final url = Uri.https('flutter-prep-default-rtdb.firebaseio.com',
  //       'shopping-list/${item.id}.json');

  //   final response = await http.delete(url);

  //   if (response.statusCode >= 400) {
  //     // Optional: Show error message
  //     setState(() {
  //       _groceryItems.insert(index, item);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }
    Widget getRow(int index) {
      return SizedBox(
        height: 80,
        child: Card(
          shape: const RoundedRectangleBorder(
            //<-- SEE HERE
            side: BorderSide(
              color: defaultBorder,
            ),
          ),
          color: defaultBackground,
          child: ListTile(
            leading: SizedBox(
              height: 50.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: const SizedBox(
                  height: 200.0,
                  width: 100.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
                // Image.network(
                //   subject['images']['large'],
                //   height: 150.0,
                //   width: 100.0,
                // ),
              ),
            ),

            // CircleAvatar(
            //   backgroundColor: defaultBorder,
            //   child: Text(
            //     _items[index].name,
            //     style: const TextStyle(
            //         fontWeight: FontWeight.bold, color: defaultText),
            //   ),
            // ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _items[index].name,
                  style: const TextStyle(color: defaultText),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _items[index].price.round().toString().toVND(),
                    style: const TextStyle(color: defaultPrice),
                  ),
                ),
              ],
            ),
            trailing: SizedBox(
              width: 50,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        //
                        // nameController.text = contacts[index].name;
                        // contactController.text = contacts[index].contact;
                        setState(() {
                          // selectedIndex = index;
                        });
                        //
                      },
                      child: const Icon(Icons.edit)),
                  InkWell(
                      onTap: (() {
                        //
                        setState(() {
                          // contacts.removeAt(index);
                        });
                        //
                      }),
                      child: const Icon(Icons.delete)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_items.isNotEmpty) {
      content = ListView.builder(
        // padding: EdgeInsets.all(12.0),
        itemCount: _items.length,
        itemBuilder: (ctx, index) => getRow(index),
        // Dismissible(
        // onDismissed: (direction) {
        //   _removeItem(_items[index]);
        // },
        //   key: ValueKey(_items[index].id),
        //   child: ListTile(
        //     title: SizedBox(
        //       width: 500, // set this
        //       child: Column(
        //         children: [
        //           Align(
        //             alignment: Alignment.centerLeft,
        //             child: Text(_items[index].name),
        //           ),
        //           Align(
        //             alignment: Alignment.centerRight,
        //             child: Text(
        //               _items[index].price.round().toString().toVND(),
        //               style: const TextStyle(color: defaultPrice),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     leading: Container(
        //       width: 50,
        //       height: 50,
        //       color: defaultBorder,
        //     ),
        //     trailing: SizedBox(
        //       // width: 100,
        //       // height: 200,
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           IconButton(
        //               constraints: const BoxConstraints(maxWidth: 0),
        //               color: defaultBorder,
        //               onPressed: () {},
        //               icon: const Icon(
        //                 Icons.edit,
        //                 size: 20,
        //               )),
        //           IconButton(
        //               constraints: const BoxConstraints(maxWidth: 0),
        //               color: defaultBorder,
        //               onPressed: () => {},
        //               icon: const Icon(
        //                 Icons.delete,
        //                 size: 20,
        //               )),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
