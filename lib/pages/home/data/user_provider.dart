import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_main_example/pages/home/domain/models/user_model.dart';

abstract class IUserProvider {
  Future<UserModel> getUser(String id);
  Future<List<UserModel>> getAllUser();
  Future<UserModel> storeUser(UserModel request);
  Future<UserModel> editUser(UserModel user);
  Future<UserModel> updateUser(UserModel request, UserModel user);
  Future<bool> deleteUser(UserModel user);
}

class UserProvider implements IUserProvider {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

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
    try {
      // final _doc = await _store.collection("users").doc(id).get();

      final userRef = await _store
          .collection("users")
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .doc(id)
          .get();

      final UserModel user = userRef.data()!;
      // print(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> storeUser(UserModel request) async {
    // TODO: Skip if user already in the DB
    final user =
        _store.collection("users").doc(request.uid).set(request.toJson());

    user.then((value) {
      // print('added user successfuly');
    }).catchError((error) {
      // print("added user failed : $error");
    });

    return request;
  }

  @override
  Future<UserModel> updateUser(UserModel request, UserModel user) {
    throw UnimplementedError();
  }
}
