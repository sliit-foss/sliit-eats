import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';

class ProductService {
  static Future<dynamic>? getProductById(String id) async {
    return true;
    // List<dynamic> filters = [{'name': 'id', 'value': id}];
    // final responseDoc = await FirestoreService.read('products', filters, limit: 1);
    // return Product.fromDocumentSnapshot(responseDoc);
  }

}
