import 'package:firebase_auth/firebase_auth.dart';

import 'package:getx_main_example/pages/home/data/auth_firebase_provider.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  IAuthFirebaseProvider authProvider;

  AuthRepository({
    required this.authProvider,
  });

  @override
  Future<UserCredential> createUser(String email, String password) async {
    try {
      return authProvider.createUser(email, password);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<UserCredential> loginUser(String email, String password) async {
    return authProvider.loginUser(email, password);
  }

  @override
  Future<void> logoutUser() async {
    return authProvider.logoutUser();
  }

  @override
  Future<UserCredential> loginUserAsAnonymous() async {
    return authProvider.loginUserAsAnonymous();
  }
}
