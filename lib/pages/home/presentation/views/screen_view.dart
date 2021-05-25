import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/login_option_view.dart';
import 'package:getx_main_example/pages/home/presentation/views/main_view.dart';

class ScreenView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.authUser != null) {
          return MainView();
        } else {
          return LoginOptionView();
        }
      }),
    );
  }
}
