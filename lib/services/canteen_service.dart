import 'package:sliit_eats/models/canteen.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';

class CanteenService {
  static Future<List<Canteen>>? getCanteens() async {
    final responseDoc = await FirestoreService.read('canteens', []);
    return (responseDoc as List).map((responseDoc) => Canteen.fromDocumentSnapshot(responseDoc)).toList();
  }
}
