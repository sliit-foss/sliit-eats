class Product {
  final String id;
  final String name;
  final String canteen;
  final String category;
  final String image;
  final String description;
  final int unitPrice;
  final int servings;
  final int unitsLeft;

  Product(
      {required this.id,
      required this.name,
      required this.canteen,
      required this.category,
      required this.unitPrice,
      required this.servings,
      required this.image,
      required this.description,
      required this.unitsLeft});

  factory Product.fromDocumentSnapshot(dynamic doc) {
    return Product(
      id: doc.data()['id'],
      canteen: doc.data()['canteen_id'],
      category: doc.data()['category_id'],
      name: doc.data()['name'],
      servings: doc.data()['servings'],
      unitPrice: doc.data()['unit_price'],
      image: doc.data()['image'],
      description: doc.data()['description'],
      unitsLeft: doc.data()['units_left'],
    );
  }
}
