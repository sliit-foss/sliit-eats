import 'package:sliit_eats/models/canteen.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';

class CanteenService {
  static Future<List<Canteen>>? getCanteens({dynamic filters}) async {
    final responseDocs = await FirestoreService.read('canteens', []);
    return (responseDocs as List)
        .map((responseDoc) => Canteen.fromDocumentSnapshot(responseDoc))
        .toList();
  }

  static Future<String?> getCanteenName(String id) async {
    List<dynamic> filters = [
      {'name': 'id', 'value': id}
    ];
    final responseDoc =
        await FirestoreService.read('canteens', filters, limit: 1);
    if (responseDoc != null)
      return Canteen.fromDocumentSnapshot(responseDoc).name;
    return null;
  }
}
