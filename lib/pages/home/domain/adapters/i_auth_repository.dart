import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<void> createUser(
      {required String name, required String email, required String password});
  Future<void> loginUser(String email, String password);
  Future<void> loginUserAsAnonymous();
  Future<void> loginWithFacebook();
  Future<void> loginWithGoogle();
  Future<void> loginWithTwitter();
  Future<void> logoutUser();
}
