import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sliit_eats/helpers/constants.dart';
import 'package:sliit_eats/models/error_message.dart';
import 'package:sliit_eats/models/sucess_message.dart';

class FirestoreService {

  static Future<dynamic> write(String collection, dynamic payload, String successMessage) async{
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

}