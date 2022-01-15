import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/auth_service.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';

class UserService {
  static Future<List<UserModel>>? getAllUsers() async {
    UserModel? currentUser = await AuthService.getCurrentUserDetails();
    List<dynamic> filters = [{'name': 'canteen_id', 'value': currentUser!.canteenId}];
    List<dynamic> sorts = [{'name': 'is_active', 'descending': true}];
    final responseDocs = await FirestoreService.read('users', filters, sorts: sorts);
    return (responseDocs as List).map((responseDoc) => UserModel.fromDocumentSnapshot(responseDoc)).toList();
  }

  static Future<dynamic>? updateActiveStatus(String userId, bool activeStatus) async {
      List<dynamic> filters = [{'name': 'id', 'value': userId}];
      return await FirestoreService.update('users', filters, {'is_active' : activeStatus});
  }
}
