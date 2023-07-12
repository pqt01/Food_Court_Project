import 'package:food_court_project/models/category.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.urlImage,
    required this.categoryId,
  });

  final String id;
  final String name;
  final double price;
  final String urlImage;
  final String categoryId;
}

Product convertProduct(Map item) {
  Product product = Product(
    id: item['id'],
    name: item['name'],
    price: item['price'],
    urlImage: item['urlImage'],
    categoryId: item['shopCategoryId'],
  );
  return product;
}
