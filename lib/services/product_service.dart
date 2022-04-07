import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliit_eats/models/general/error_message.dart';
import 'package:sliit_eats/models/product.dart';
import 'package:sliit_eats/services/firebase_services/firebase_storage_service.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';

class ProductService {
  static Future<Product?> getProductById(String id) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    final responseDoc = await FirestoreService.read('products', filters, limit: 1);
    if (responseDoc != null) return Product.fromDocumentSnapshot(responseDoc);
    return null;
  }

  static Future<dynamic>? addNewProduct(String canteenID, Product newProduct, File file) async {
    final res = await filterProducts(newProduct.canteen, "all", newProduct.name);
    if (res.isNotEmpty) return ErrorMessage('A product by this name already exists');

    newProduct.id = UniqueKey().toString();

    newProduct.image = await FirebaseStorageService.uploadFile(file, newProduct.id, 'products');
    print('imag : ' + newProduct.image);

    return await FirestoreService.write('products', Product.toJSONObject(newProduct, true), 'Product added successfully');
  }

  static dynamic uploadImage(File file, String fileName) async {
    String imageURL = await FirebaseStorageService.uploadFile(file, fileName, 'products');

    return await FirestoreService.update('products', [
      {'name': 'id', 'value': fileName}
    ], {
      'image': imageURL
    });
  }

  static Future<dynamic>? updateProduct(Product updatedProduct) async {
    final res = await filterProducts("all", "all", updatedProduct.name);
    if (res != null && res[0].id != updatedProduct.id) return ErrorMessage('A product by this name already exists');
    List<dynamic> filters = [
      {'name': 'id', 'value': updatedProduct.id}
    ];
    return await FirestoreService.update('products', filters, Product.toJSONObject(updatedProduct, false));
  }

  static Future<dynamic>? updateUnitsLeftOfProduct(String id, bool isBought, int units) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    if (isBought)
      return await FirestoreService.update('products', filters, {'units_left': FieldValue.increment(-1 * units)});
    else
      return await FirestoreService.update('products', filters, {'units_left': FieldValue.increment(units)});
  }

  static Future<dynamic>? deleteProduct(String id) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];

    await FirebaseStorageService.deleteFile(id, 'products');
    return await FirestoreService.delete('products', filters);
  }

  static Future<List<Product>> filterProducts(String canteenID, String categoryID, String productName) async {
    List<dynamic> filters = [];

    if (categoryID != "all") filters.add({'name': 'category_id', 'value': categoryID});

    if (canteenID != "all") filters.add({'name': 'canteen_id', 'value': canteenID});

    if (productName != "") filters.add({'name': 'name', 'value': productName});

    final responsesDocs = await FirestoreService.read('products', filters);
    return (responsesDocs as List).map((responsesDoc) => Product.fromDocumentSnapshot(responsesDoc)).toList();
  }
}
