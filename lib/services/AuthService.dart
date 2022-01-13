import 'package:firebase_auth/firebase_auth.dart';
import 'package:sliit_eats/helpers/cache_service.dart';
import 'package:sliit_eats/helpers/constants.dart';
import 'package:sliit_eats/models/error_message.dart';
import 'package:sliit_eats/models/sucess_message.dart';
import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/firebase_services/FirestoreService.dart';

class AuthService {
  static Future<String>? forgotPasswordEmail(String email) {
    // implement forgotPasswordEmail
    return null;
  }

  static Future<dynamic>? getCurrentUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<dynamic> filters = [{'name': 'id', 'value' : user!.uid}];
    final responseDoc = await FirestoreService.read('users', filters, limit: 1);
    return UserModel.fromDocumentSnapshot(responseDoc);
  }

  static Future<dynamic>? signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (!user!.emailVerified) {
        await sendVerificationMail();
        return ErrorMessage('Please verify your email');
      }
      return SuccessMessage("Signed in Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found')
       return ErrorMessage('No user found for that email');
      if (e.code == 'wrong-password')
        return ErrorMessage('Invalid password');
      return ErrorMessage(Constants.errorMessages['default']!);
    }
  }

  static Future<void>? signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<dynamic>? signUp(String email, String password, String name, bool isAdmin, String userType) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await user!.updateDisplayName(name);
      await sendVerificationMail();
      return await FirestoreService.write('users', { 'id': user.uid, 'username': name, 'email': email, 'user_type': userType, 'is_admin' : isAdmin }, 'Signed up successfully. Please verify your email to activate your account');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        return ErrorMessage('The password provided is too weak');
      if (e.code == 'email-already-in-use')
        return ErrorMessage('The account already exists for that email');
      return ErrorMessage(Constants.errorMessages['default']!);
    } catch (e) {
      print(e);
      return ErrorMessage(Constants.errorMessages['default']!);
    }
  }

  static Future<void>? sendVerificationMail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user!= null && !user.emailVerified)
      await user.sendEmailVerification();
  }
}
