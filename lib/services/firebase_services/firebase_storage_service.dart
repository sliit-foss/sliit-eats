import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadFile(File file, String fileName, String filepath) async {
    var storageRef = storage.ref().child('/$filepath/$fileName');

    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  static Future<void> deleteFile(String fileName, String filepath) async {
    var storageRef = storage.ref().child('$filepath/$fileName');

    storageRef.delete().then((value) => print("File deleted successfully")).catchError((e) => print(e));
  }
}
