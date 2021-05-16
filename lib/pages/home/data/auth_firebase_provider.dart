import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/firebase/firebase_auth_instance.dart';

abstract class IAuthFirebaseProvider {
  Future<UserCredential> createUser(String email, String password);
  Future<UserCredential> loginUser(String email, String password);
  Future<UserCredential> loginUserAsAnonymous();
  Future<void> logoutUser();
}

class AuthFirebaseProvider implements IAuthFirebaseProvider {
  final FirebaseAuth _auth = Get.find<FirebaseAuthInstance>().instance;

  @override
  Future<UserCredential> createUser(String email, String password) async {
    try {
      return _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw Exception('Firebase error: ${error.message}');
    } on Exception catch (e) {
      throw Exception('Exception: ${e.toString()}');
    }
  }

  @override
  Future<UserCredential> loginUser(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> loginUserAsAnonymous() async {
    return _auth.signInAnonymously();
  }

  @override
  Future<void> logoutUser() async {
    return _auth.signOut();
  }
}
