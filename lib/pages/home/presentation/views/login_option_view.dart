import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/login_form_view.dart';
import 'package:getx_main_example/pages/home/presentation/views/register_view.dart';

class LoginOptionView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Options'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => Get.to(() => LoginFormView()),
                child: const Text('Login Account'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(() => RegisterView()),
                child: const Text('Register Account'),
              ),
            ],
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () => _handleAnonymous(),
            child: const Text('Sign Anonymous'),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _handleGoogle(),
                child: const Text('Google'),
              ),
              ElevatedButton(
                onPressed: () => _handleFacebook(),
                child: const Text('Facebook'),
              ),
              ElevatedButton(
                onPressed: () => _handleTwitter(),
                child: const Text('Twitter'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _handleTwitter() {
    controller.loginWithTwitter();
  }

  void _handleGoogle() {
    controller.loginWithGoogle();
  }

  void _handleFacebook() {
    controller.loginWithFacebook();
  }

  void _handleAnonymous() {
    controller.loginAsAnonymous();
  }
}
