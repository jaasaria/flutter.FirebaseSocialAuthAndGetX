import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_main_example/pages/home/domain/entity/user_model.dart';

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
    print('getting user from cloud store: $id');
    try {
      final _doc = await _store.collection("users").doc(id).get();

      final userRef = await _store
          .collection("users")
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .doc(id)
          .get();

      if (userRef.exists) {
        print('user is exist');
      }
      print(_doc.data());

      UserModel user = userRef.data()!;
      print(user.toString());
      return user;
    } catch (e) {
      print('getting user from cloud store - error');
      print(e);
      rethrow;
    }
  }

  @override
  Future<UserModel> storeUser(UserModel request) async {
    final user =
        _store.collection("users").doc(request.uid).set(request.toJson());

    user.then((value) {
      print("User Added");
    }).catchError((error) => print("Failed to add user: $error"));

    return request;
  }

  @override
  Future<UserModel> updateUser(UserModel request, UserModel user) {
    throw UnimplementedError();
  }
}
