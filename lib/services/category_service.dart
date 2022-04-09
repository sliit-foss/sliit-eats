import 'package:flutter/material.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/models/general/error_message.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';
import 'package:sliit_eats/services/product_service.dart';

class CategoryService {
  static Future<List<Category>>? getCategories({dynamic filters}) async {
    final responseDocs = await FirestoreService.read('categories', filters != null ? filters : []);
    return (responseDocs as List).map((responseDoc) => Category.fromDocumentSnapshot(responseDoc)).toList();
  }

  static Future<Category?> getCategoryByName(String name) async {
    List<dynamic> filters = [
      {'name': 'name', 'value': name}
    ];
    final responseDoc = await FirestoreService.read('categories', filters, limit: 1);
    if (responseDoc != null) return Category.fromDocumentSnapshot(responseDoc);
    return null;
  }

  static Future<dynamic>? addCategory(String name) async {
    final res = await getCategoryByName(name);
    if (res != null) return ErrorMessage('A category by this name already exists');
    return await FirestoreService.write('categories', {'id': UniqueKey().toString(), 'name': name}, 'Category added successfully');
  }

  static Future<dynamic>? updateCategory(String id, String name) async {
    final res = await getCategoryByName(name);
    if (res != null) return ErrorMessage('A category by this name already exists');
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    return await FirestoreService.update('categories', filters, {'name': name});
  }

  static Future<dynamic>? deleteCategory(String id) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    final res = await ProductService.filterProducts('all', id, '');
    if (res.isNotEmpty) return ErrorMessage('This category has products! Please delete all products under this category to proceed.');
    return await FirestoreService.delete('categories', filters);
  }
}
