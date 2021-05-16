import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_auth_repository.dart';
import 'package:getx_main_example/pages/home/domain/entity/user_model.dart';
import 'package:getx_main_example/pages/home/domain/firebase/firebase_auth_instance.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/user_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = Get.find<FirebaseAuthInstance>().instance;
  final UserController _storeUser = Get.find();
  final IAuthRepository repository;
  final Rxn<User> _authUser = Rxn<User>();

  AuthController({required this.repository});

  @override
  void onInit() {
    super.onInit();

    _authUser.bindStream(_auth.authStateChanges());

    once(_authUser, (_) {
      if (authUser != null && authUser!.uid.isNotEmpty) {
        _storeUser.getUser(authUser!.uid);
      }
    });
  }

  User? get authUser => _authUser.value;
  UserModel? get storeUser => _storeUser.user;

  Future<UserCredential> loginUser(String email, String password) async {
    final auth =
        await repository.loginUser(email, password).then((value) async {
      await _storeUser.getUser(authUser!.uid);
      return value;
    });

    return auth;
  }

  Future<UserCredential> createUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final auth = repository.createUser(email, password);
      auth.then((value) async {
        final userModel = UserModel(
            uid: value.user!.uid,
            name: name,
            email: email,
            createdAt: DateTime.now());

        await savingAndAssignFireUser(userModel);
      });

      return auth;
    } on FirebaseAuthException catch (error) {
      throw Exception('Firebase error: ${error.message}');
    } on Exception catch (e) {
      throw Exception('Exception: ${e.toString()}');
    }
  }

  Future<UserCredential> loginUserAsAnonymous() async {
    final user = await repository.loginUserAsAnonymous().then((value) async {
      final userModel = UserModel(
          uid: value.user!.uid,
          name: 'Anonymous',
          email: 'Anonymous',
          createdAt: DateTime.now());
      await savingAndAssignFireUser(userModel);
      return value;
    });

    return user;
  }

  Future<UserCredential> loginInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = FirebaseAuth.instance.signInWithCredential(credential);

    return user.then((value) async {
      final userModel = UserModel(
          uid: value.user!.uid,
          name: value.user?.displayName ?? 'sign as google',
          email: value.user!.email!,
          createdAt: DateTime.now());

      await savingAndAssignFireUser(userModel);
      return value;
    });
  }

  Future<UserCredential> loginInWithFacebook() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    final credential = FacebookAuthProvider.credential(res.accessToken!.token);

    // you may use this scopes
    // final profile = await fb.getUserProfile();
    // final imageUrl = await fb.getProfileImageUrl(width: 100);
    // final email = await fb.getUserEmail();

    final user = FirebaseAuth.instance.signInWithCredential(credential);

    return user.then((value) async {
      final userModel = UserModel(
          uid: value.user!.uid,
          name: value.user?.displayName ?? 'sign as facebook',
          email: value.user!.email!,
          createdAt: DateTime.now());

      await savingAndAssignFireUser(userModel);
      return value;
    });
  }

  Future<UserCredential> loginInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: 'MbToJGnLsiociDZEhH1HkOee5',
      apiSecretKey: 'ZyTBS2KAuyINNqHZlFbDHALEF3feCvd9Tb7zbo7DU6zvdQQelc',
      redirectURI: 'example://',
    );
    final authResult = await twitterLogin.login();

    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken ?? '',
        secret: authResult.authTokenSecret ?? '');

    final user =
        FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);

    return user.then((value) async {
      final userModel = UserModel(
          uid: value.user!.uid,
          name: value.user?.displayName ?? 'sign as twitter',
          email: value.user!.email!,
          createdAt: DateTime.now());

      await savingAndAssignFireUser(userModel);
      return value;
    });
  }

  void logoutUser() {
    repository.logoutUser();
    _storeUser.logoutUser();
  }

  Future<void> savingAndAssignFireUser(UserModel userModel) async {
    await _storeUser.storeUser(userModel).then((value) {
      Get.find<UserController>().user = value;
    });
  }
}
