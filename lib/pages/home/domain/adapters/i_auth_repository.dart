import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<UserCredential> createUser(String email, String password);
  Future<UserCredential> loginUser(String email, String password);
  Future<UserCredential> loginUserAsAnonymous();
  Future<void> logoutUser();
}
