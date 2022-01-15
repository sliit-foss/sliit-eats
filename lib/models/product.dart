import 'dart:ffi';

class Product {
  final String name;
  final String canteen;
  final String category;
  final Float unitPrice;
  final int servings;

  Product(
      {required this.name,
      required this.canteen,
      required this.category,
      required this.unitPrice,
      required this.servings});
}
