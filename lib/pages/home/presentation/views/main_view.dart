import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/user_controller.dart';

class MainView extends GetView<AuthController> {
  final UserController _user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GetX<AuthController>(
                initState: (_) {},
                builder: (_) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('User UID:  ${controller.storeUser?.uid}'),
                      Text(
                          'You are successfull login:  ${controller.storeUser?.email}'),
                      Text('name of User:  ${_user.user?.name}'),
                      ElevatedButton(
                        onPressed: () {
                          controller.logoutUser();
                        },
                        child: const Text('Sign Out'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Before getting ');
                          _user.getUser(controller.authUser!.uid);
                          print('value of user: ');
                          print(_user.user.toString());
                        },
                        child: const Text('Check Get User'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
