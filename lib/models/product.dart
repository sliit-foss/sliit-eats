class Product {
  String id = '';
  final String name;
  final String canteen;
  final String category;
  String image = '';
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

  Product.updatedProduct(
      {required this.id,
      required this.name,
      required this.canteen,
      required this.category,
      required this.unitPrice,
      required this.servings,
      required this.description,
      required this.unitsLeft});
  Product.newProduct(
      {required this.name,
      required this.canteen,
      required this.category,
      required this.unitPrice,
      required this.servings,
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

  static toJSONObject(Product product, bool isNewProduct) {
    if (isNewProduct)

            return {
        'id': product.id,
        'canteen_id': product.canteen,
        'image': product.image,
        'name': product.name,
        'category_id': product.category,
        'servings': product.servings,
        'unit_price': product.unitPrice,
        'description': product.description,
        'units_left': product.unitsLeft
      };
    else
      return {
        'name': product.name,
        'category_id': product.category,
        'servings': product.servings,
        'unit_price': product.unitPrice,
        'description': product.description,
        'units_left': product.unitsLeft
      };
  }
}
