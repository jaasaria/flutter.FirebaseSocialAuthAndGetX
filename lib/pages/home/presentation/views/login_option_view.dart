import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/login_form_view.dart';
import 'package:getx_main_example/pages/home/presentation/views/register_view.dart';
import 'package:social_auth_buttons/social_auth_buttons.dart';
import 'package:textless/textless.dart';

class LoginOptionView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Login with Email and Password'.text,
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.indigo),
                  onPressed: () => Get.to(() => LoginFormView()),
                  child: SizedBox(
                    width: double.infinity,
                    child: 'Login Account'.text.color(Colors.white).alignCenter,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                  onPressed: () => Get.to(() => RegisterView()),
                  child: SizedBox(
                    width: double.infinity,
                    child:
                        'Register Account'.text.color(Colors.white).alignCenter,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            'Login as Anonymous'.text,
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () => _handleAnonymous(),
              child: SizedBox(
                  width: double.infinity,
                  child:
                      'Sign as Anonymous'.text.color(Colors.white).alignCenter),
            ),
            const SizedBox(
              height: 20,
            ),
            'Login with Social Media'.text,
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleAuthButton(
                    onPressed: () => _handleGoogle(),
                    style: AuthButtonStyle.icon,
                    borderColor: Colors.white),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FacebookAuthButton(
                      onPressed: () => _handleFacebook(),
                      style: AuthButtonStyle.icon,
                      borderColor: Colors.white),
                ),
                TwitterAuthButton(
                    onPressed: () => _handleTwitter(),
                    style: AuthButtonStyle.icon,
                    borderColor: Colors.white),
              ],
            ),
          ],
        ),
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
