import 'package:firebase_auth/firebase_auth.dart';

import 'package:getx_main_example/pages/home/data/auth_firebase_provider.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_auth_repository.dart';
import 'package:getx_main_example/pages/home/domain/models/user_model.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/user_controller.dart';

class AuthRepository implements IAuthRepository {
  IAuthFirebaseProvider authProvider;
  UserController userController;

  AuthRepository({
    required this.authProvider,
    required this.userController,
  });

  @override
  Future<void> createUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final value = await authProvider.createUser(email, password);
      final userModel = UserModel(
          uid: value.user!.uid,
          name: name,
          email: email,
          createdAt: DateTime.now());
      await userController.addAndAsignUser(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      final value = await authProvider.loginUser(email, password);
      await userController.getUser(value.user!.uid);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logoutUser() async {
    return authProvider.logoutUser();
  }

  @override
  Future<void> loginUserAsAnonymous() async {
    try {
      final value = await authProvider.loginUserAsAnonymous();
      final userModel = UserModel(
          uid: value.user!.uid,
          name: 'Anonymous',
          email: 'Anonymous',
          createdAt: DateTime.now());
      await userController.addAndAsignUser(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> loginWithFacebook() async {
    try {
      final value = await authProvider.loginWithFacebook();
      final userModel = UserModel(
          uid: value.user!.uid,
          name: value.user?.displayName ?? 'Facebook',
          email: value.user!.email!,
          createdAt: DateTime.now());
      await userController.addAndAsignUser(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> loginWithGoogle() async {
    try {
      final value = await authProvider.loginWithFacebook();
      final userModel = UserModel(
          uid: value.user!.uid,
          name: value.user?.displayName ?? 'Google',
          email: value.user!.email!,
          createdAt: DateTime.now());
      await userController.addAndAsignUser(userModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> loginWithTwitter() async {
    try {
      final value = await authProvider.loginWithTwitter();
      final userModel = UserModel(
          uid: value.user!.uid,
          name: value.user?.displayName ?? 'Twitter',
          email: value.user!.email!,
          createdAt: DateTime.now());
      await userController.addAndAsignUser(userModel);
    } catch (e) {
      rethrow;
    }
  }
}
