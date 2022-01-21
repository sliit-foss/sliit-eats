import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sliit_eats/models/general/error_message.dart';
import 'package:sliit_eats/models/product.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';

class ProductService {
  static Future<Product?> getProductById(String id) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    final responseDoc =
        await FirestoreService.read('products', filters, limit: 1);
    if (responseDoc != null) return Product.fromDocumentSnapshot(responseDoc);
    return null;
  }

  static Future<dynamic>? addNewProduct(
      String canteenID, Product newProduct) async {
    final res = await filterProducts(canteenID, "", newProduct.name);
    if (res != null)
      return ErrorMessage('A product by this name already exists');

    //     {'id': UniqueKey().toString(), 'name': name},

    return await FirestoreService.write(
        'products', newProduct, 'Product added successfully');
  }

  static Future<dynamic>? updateProduct(
      String id, String canteenID, Product updatedProduct) async {
    final res = await filterProducts(canteenID, "", updatedProduct.name);
    if (res != null)
      return ErrorMessage('A product by this name already exists');
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    return await FirestoreService.update('products', filters, updatedProduct);
  }

  static Future<dynamic>? updateUnitsLeftOfProduct(
      String id, bool isBought, int units) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    if (isBought)
      return await FirestoreService.update('products', filters,
          {'units_left': FieldValue.increment(-1 * units)});
    else
      return await FirestoreService.update(
          'products', filters, {'units_left': FieldValue.increment(units)});
  }

  static Future<dynamic>? deleteProduct(String id) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    return await FirestoreService.delete('products', filters);
  }

  static Future<List<Product>> filterProducts(
      String canteenID, String categoryID, String productName) async {
    List<dynamic> filters = [];

    if (categoryID != "all")
      filters.add({'name': 'category_id', 'value': categoryID});

    if (canteenID != "all")
      filters.add({'name': 'canteen_id', 'value': canteenID});

    if (productName != "") filters.add({'name': 'name', 'value': productName});

    final responsesDocs = await FirestoreService.read('products', filters);
    return (responsesDocs as List)
        .map((responsesDoc) => Product.fromDocumentSnapshot(responsesDoc))
        .toList();
  }
}
