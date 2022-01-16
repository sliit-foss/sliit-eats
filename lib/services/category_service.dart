import 'package:flutter/material.dart';
import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';
import 'auth_service.dart';

class CategoryService {

  static Future<List<Category>>? getCategories({ dynamic filters }) async {
    final responseDocs = await FirestoreService.read('categories', filters != null ? filters : []);
    return (responseDocs as List).map((responseDoc) => Category.fromDocumentSnapshot(responseDoc)).toList();
  }

  static Future<dynamic>? addCategory(String name) async {
    UserModel? currentUser = await AuthService.getCurrentUserDetails();
    return await FirestoreService.write('categories', {'id': UniqueKey().toString(), 'name': name, 'canteen_id': currentUser!.canteenId}, 'Category added successfully');
  }

  static Future<dynamic>? updateCategory(String id, String name) async {
    List<dynamic> filters = [{'name': 'id', 'value': id}];
    return await FirestoreService.update('categories', filters, {'name':name});
  }

  static Future<dynamic>? deleteCategory(String id) async {
    List<dynamic> filters = [{'name': 'id', 'value': id}];
    return await FirestoreService.delete('categories', filters);
  }

}
