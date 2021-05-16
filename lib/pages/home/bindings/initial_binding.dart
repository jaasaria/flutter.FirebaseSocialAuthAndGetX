import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/data/auth_firebase_provider.dart';
import 'package:getx_main_example/pages/home/data/auth_repository.dart';
import 'package:getx_main_example/pages/home/data/user_provider.dart';
import 'package:getx_main_example/pages/home/data/user_repository.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_auth_repository.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_user_repository.dart';
import 'package:getx_main_example/pages/home/domain/firebase/firebase_auth_instance.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/user_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseAuthInstance(), permanent: true);

    // User
    Get.put<IUserProvider>(UserProvider(), permanent: true);
    Get.put<IUserRepository>(UserRepository(userProvider: Get.find()),
        permanent: true);
    Get.put(UserController(repository: Get.find()), permanent: true);

    // Auth
    Get.put<IAuthFirebaseProvider>(AuthFirebaseProvider(), permanent: true);
    Get.put<IAuthRepository>(AuthRepository(authProvider: Get.find()),
        permanent: true);
    Get.put(AuthController(repository: Get.find()), permanent: true);
  }
}
