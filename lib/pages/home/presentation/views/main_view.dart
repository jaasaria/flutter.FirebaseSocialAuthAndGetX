import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/user_controller.dart';
import 'package:textless/textless.dart';

class MainView extends GetView<AuthController> {
  final UserController _user = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.indigo),
                          onPressed: () {
                            controller.logoutUser();
                          },
                          child: SizedBox(
                              width: double.infinity,
                              child: 'Sign Out'.text.alignCenter),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
