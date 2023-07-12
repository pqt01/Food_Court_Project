import 'dart:convert';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

import 'package:flutter/material.dart';
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

    if (_items.isNotEmpty) {
      content = ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, index) => Dismissible(
          // onDismissed: (direction) {
          //   _removeItem(_items[index]);
          // },
          key: ValueKey(_items[index].id),
          child: ListTile(
            title: Text(_items[index].name),
            // leading: Container(
            //   width: 24,
            //   height: 24,
            //   color: _items[index].category.color,
            // ),
            trailing: Text(
              _items[index].price.round().toString().toVND(),
            ),
          ),
        ),
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
