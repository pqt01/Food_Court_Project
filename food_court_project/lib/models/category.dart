class Category {
  const Category({required this.id, required this.name, required this.shopId});

  final String id;
  final String name;
  final String shopId;
}

Category convertCategory(Map item) {
  Category category = Category(
    id: item['id'],
    name: item['name'],
    shopId: item['shopId'],
  );
  return category;
}
