import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sliit_eats/helpers/constants.dart';
import 'package:sliit_eats/models/general/error_message.dart';
import 'package:sliit_eats/models/general/sucess_message.dart';
import 'package:sliit_eats/models/user.dart';
import 'package:sliit_eats/services/firebase_services/firestore_service.dart';
import 'package:sliit_eats/services/user_service.dart';
import '../main.dart';

class AuthService {

  static Future<dynamic>? getCurrentUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<dynamic> filters = [{'name': 'id', 'value': user!.uid}];
    final responseDoc = await FirestoreService.read('users', filters, limit: 1);
    print(responseDoc);
    return UserModel.fromDocumentSnapshot(responseDoc);
  }

  static Future<dynamic>? signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      currentLoggedInUser = await AuthService.getCurrentUserDetails();
      if (!currentLoggedInUser.isActive)
        return ErrorMessage('Your account has been deactivated');
      if (!user!.emailVerified) {
        await user.sendEmailVerification();
        return ErrorMessage('Please verify your email');
      }
      String? firebaseToken= await FirebaseMessaging.instance.getToken();
      await UserService.updateFCMToken(user.uid, firebaseToken!);
      return SuccessMessage("Signed in Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return ErrorMessage('No user found for that email');
      if (e.code == 'wrong-password') return ErrorMessage('Invalid password');
      if (e.code == 'invalid-email') return ErrorMessage('The email address is badly formatted');
      return ErrorMessage(Constants.errorMessages['default']!);
    }
  }

  static Future<dynamic>? signUp(String email, String password, String name, bool isAdmin, String userType) async {
    try {
      String canteenId = '';
      if (isAdmin) {
        UserModel? currentUser = await AuthService.getCurrentUserDetails();
        canteenId = currentUser!.canteenId!;
      }
      FirebaseApp tempApp = Firebase.app("temporaryregister");
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: tempApp).createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.sendEmailVerification();
      return await FirestoreService.write('users', {'id': user.uid, 'username': name, 'email': email, 'user_type': userType, 'is_admin': isAdmin, 'canteen_id': canteenId, 'is_active' : true },
          'Signed up successfully. Please verify your email to activate your account');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') return ErrorMessage('The password provided is too weak');
      if (e.code == 'email-already-in-use') return ErrorMessage('The account already exists for that email');
      return ErrorMessage(Constants.errorMessages['default']!);
    } catch (e) {
      print(e);
      return ErrorMessage(Constants.errorMessages['default']!);
    }
  }

  static Future<void>? signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<dynamic>? updatePassword(String password) async {
    dynamic res;
    User? user = FirebaseAuth.instance.currentUser;
    await user!.updatePassword(password).then((val){
      res = SuccessMessage('Password updated successfully');
    }).catchError((err){
      print(err.code);
      if (err.code == 'weak-password') {
        res = ErrorMessage('The password provided is too weak');
      }else{
        res = ErrorMessage(Constants.errorMessages['default']!);
      }
    });
    return res;
  }
}
