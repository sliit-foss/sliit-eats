import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sliit_eats/helpers/constants.dart';
import 'package:sliit_eats/models/general/error_message.dart';
import 'package:sliit_eats/models/general/sucess_message.dart';

class FirestoreService {
  static Future<dynamic> write(String collection, dynamic payload, String successMessage) async {
    dynamic res;
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('users');
    await collectionRef.add(payload).then((value) {
      res = SuccessMessage(successMessage);
    }).catchError((error) {
      print(error);
      res = ErrorMessage(Constants.errorMessages['default']!);
    });
    return res;
  }

  static Future<dynamic> read(String collection, List<dynamic> filters, {limit}) async {
    List<dynamic> data = [];
    dynamic collectionRef = FirebaseFirestore.instance.collection(collection);
    filters.forEach((filter) {
      collectionRef = collectionRef.where(filter['name'], isEqualTo: filter['value']);
    });
    if (limit != null) collectionRef = collectionRef.limit(limit);
    await collectionRef.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length > 0) data = querySnapshot.docs;
    });
    return limit == 1 ? data[0] : data;
  }
}
