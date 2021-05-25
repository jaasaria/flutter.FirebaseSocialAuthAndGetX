import 'package:get/get.dart';

import 'package:getx_main_example/pages/home/domain/adapters/i_user_repository.dart';
import 'package:getx_main_example/pages/home/domain/entity/failure.dart';
import 'package:getx_main_example/pages/home/domain/models/user_model.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper.dart';

class UserController extends GetxController with IUserRepository {
  final IUserRepository repository;
  final Rxn<UserModel?> _user = Rxn<UserModel>();

  UserController({
    required this.repository,
  });

  UserModel? get user => _user.value;
  set user(UserModel? user) {
    _user.value = user;
  }

  // set user(UserModel value) => this._userModel.value = value;

  @override
  Future<bool> deleteUser(UserModel user) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> editUser(UserModel user) {
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getAllUser() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUser(String id) async {
    final user = await repository.getUser(id);
    _user(user);
    return user;
  }

  @override
  Future<UserModel> storeUser(UserModel request) async {
    return repository.storeUser(request);
  }

  @override
  Future<UserModel> updateUser(UserModel request, UserModel user) {
    throw UnimplementedError();
  }

  Future<void> addAndAsignUser(UserModel user) async {
    try {
      final value = await repository.storeUser(user);
      Get.find<UserController>().user = value;
    } catch (e) {
      showSnackbarFail(Failure(e.toString()));
    }
  }

  void logoutUser() {
    _user.value = null;
  }
}
