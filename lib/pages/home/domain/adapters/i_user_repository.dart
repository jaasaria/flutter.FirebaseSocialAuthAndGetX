import 'package:getx_main_example/pages/home/domain/models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> getUser(String id);
  Future<List<UserModel>> getAllUser();
  Future<UserModel> storeUser(UserModel request);
  Future<UserModel> editUser(UserModel user);
  Future<UserModel> updateUser(UserModel request, UserModel user);
  Future<bool> deleteUser(UserModel user);
}
