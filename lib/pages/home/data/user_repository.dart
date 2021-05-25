import 'package:getx_main_example/pages/home/data/user_provider.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_user_repository.dart';
import 'package:getx_main_example/pages/home/domain/models/user_model.dart';

class UserRepository implements IUserRepository {
  IUserProvider userProvider;

  UserRepository({
    required this.userProvider,
  });

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
  Future<UserModel> getUser(String id) {
    return userProvider.getUser(id);
  }

  @override
  Future<UserModel> storeUser(UserModel request) {
    return userProvider.storeUser(request);
  }

  @override
  Future<UserModel> updateUser(UserModel request, UserModel user) {
    throw UnimplementedError();
  }
}
