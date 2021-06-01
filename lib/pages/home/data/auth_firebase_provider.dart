import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/entity/failure.dart';
import 'package:getx_main_example/pages/home/domain/firebase/firebase_auth_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

abstract class IAuthFirebaseProvider {
  Future<UserCredential> createUser(String email, String password);
  Future<UserCredential> loginUser(String email, String password);
  Future<UserCredential> loginUserAsAnonymous();

  Future<UserCredential> loginWithFacebook();
  Future<UserCredential> loginWithGoogle();
  Future<UserCredential> loginWithTwitter();

  Future<void> logoutUser();
}

class AuthFirebaseProvider implements IAuthFirebaseProvider {
  final FirebaseAuth _auth = Get.find<FirebaseAuthInstance>().instance;

  @override
  Future<UserCredential> createUser(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw Failure(error.message.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<UserCredential> loginUser(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw Failure(error.message.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<UserCredential> loginUserAsAnonymous() async {
    try {
      return _auth.signInAnonymously();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<UserCredential> loginWithFacebook() async {
    try {
      final fb = FacebookLogin();

      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      final credential =
          FacebookAuthProvider.credential(res.accessToken!.token);

      // you may use this scopes
      // final profile = await fb.getUserProfile();
      // final imageUrl = await fb.getProfileImageUrl(width: 100);
      // final email = await fb.getUserEmail();

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      throw Failure(error.message.toString());
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<UserCredential> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<UserCredential> loginWithTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey: 'MbToJGnLsiociDZEhH1HkOee5',
        apiSecretKey: 'ZyTBS2KAuyINNqHZlFbDHALEF3feCvd9Tb7zbo7DU6zvdQQelc',
        redirectURI: 'example://',
      );
      final authResult = await twitterLogin.login();

      final AuthCredential twitterAuthCredential =
          TwitterAuthProvider.credential(
              accessToken: authResult.authToken ?? '',
              secret: authResult.authTokenSecret ?? '');

      return await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      late String provider = '';
      (_auth.currentUser!.providerData.isNotEmpty)
          ? provider = _auth.currentUser!.providerData[0].providerId.toString()
          : provider = 'empty';

      switch (provider) {
        case 'facebook.com':
          await fbOut();
          break;
        case 'google.com':
          await googleOut();
          break;
        default:
      }

      return _auth.signOut();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future fbOut() async {
    final fb = FacebookLogin();
    await fb.logOut();
  }

  Future googleOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}
