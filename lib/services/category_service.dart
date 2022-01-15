import 'package:sliit_eats/models/category.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';

class CategoryService {
  static Future<List<Category>>? getCategories({dynamic filters = null}) async {
    final responseDocs = await FirestoreService.read('categories', filters != null ? filters : []);
    return (responseDocs as List).map((responseDoc) => Category.fromDocumentSnapshot(responseDoc)).toList();
  }
}
