import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_court_project/constants.dart';
import 'package:food_court_project/models/category.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  List<Category> _items = [];
  var _enteredName = '';
  var _enteredPrice = 0;
  var _enteredUrlImage = 'emtry';
  var _selectedCategory;
  var _isSending = false;

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
          .get(uri("ShopCategory/GetShopCategoriesByShopId/$shopId"))
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
      final List<Category> loadedItems = [];
      for (final item in json["result"]["items"]) {
        loadedItems.add(
          convertCategory(item),
        );
      }
      setState(() {
        _items = loadedItems;
        _isLoading = false;
        _selectedCategory = _items[0];
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! Please try again later.';
      });
    }
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final response = await http.post(
        uri("Product/CreateProduct"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredName,
            'price': _enteredPrice,
            'urlImage': _enteredUrlImage,
            'shopCategoryId': _selectedCategory.id,
          },
        ),
      );

      // final Map<String, dynamic> resData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
          // GroceryItem(
          //   id: resData['name'],
          //   name: _enteredName,
          //   quantity: _enteredQuantity,
          //   category: _selectedCategory,
          // ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(
                  height: 1.5,
                  fontSize: 18,
                ),
                maxLength: 100,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  contentPadding: defaultContentPadding,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 100) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ), // instead of TextField()
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        label: Text('Price'),
                        contentPadding: defaultContentPadding,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredPrice.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPrice = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        label: Text('Catagory'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      value: _selectedCategory,
                      items: [
                        for (final category in _items)
                          DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                Text(category.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add product'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
