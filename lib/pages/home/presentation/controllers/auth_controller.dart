import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_auth_repository.dart';
import 'package:getx_main_example/pages/home/domain/entity/failure.dart';
import 'package:getx_main_example/pages/home/domain/firebase/firebase_auth_instance.dart';
import 'package:getx_main_example/pages/home/domain/models/user_model.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/user_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper.dart';
import 'package:getx_main_example/routes/app_pages.dart';

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

  Future<void> loginUser(String email, String password) async {
    loginWrapper(repository.loginUser(email, password));

    // try {
    //   showDialogHelper();
    //   await repository.loginUser(email, password);
    //   showSnackbarSuccess();
    //   Get.offAllNamed(Routes.AUTH);
    // } catch (e) {
    //   showSnackbarFail(Failure(e.toString()));
    // } finally {
    //   closeDialogHelper();
    // }
  }

  Future<void> loginAsAnonymous() async {
    loginWrapper(repository.loginUserAsAnonymous());

    // try {
    //   showDialogHelper();
    //   await repository.loginUserAsAnonymous();
    //   showSnackbarSuccess();
    //   Get.offAllNamed(Routes.AUTH);
    // } catch (e) {
    //   showSnackbarFail(Failure(e.toString()));
    // } finally {
    //   closeDialogHelper();
    // }
  }

  Future<void> loginWithGoogle() async {
    try {
      showDialogHelper();
      await repository.loginWithGoogle();
      showSnackbarSuccess();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      showSnackbarFail(Failure(e.toString()));
    } finally {
      closeDialogHelper();
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      showDialogHelper();
      await repository.loginWithFacebook();
      showSnackbarSuccess();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      showSnackbarFail(Failure(e.toString()));
    } finally {
      closeDialogHelper();
    }
  }

  Future<void> loginWithTwitter() async {
    try {
      showDialogHelper();
      await repository.loginWithTwitter();
      showSnackbarSuccess();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      showSnackbarFail(Failure(e.toString()));
    } finally {
      closeDialogHelper();
    }
  }

  Future<void> loginWrapper(Future function) async {
    try {
      showDialogHelper();
      await function;
      showSnackbarSuccess();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      showSnackbarFail(Failure(e.toString()));
    } finally {
      closeDialogHelper();
    }
  }

  void logoutUser() {
    repository.logoutUser();
    _storeUser.logoutUser();
  }
}
