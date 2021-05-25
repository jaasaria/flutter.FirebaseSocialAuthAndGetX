import 'package:flutter/material.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper.dart';
import 'package:textless/textless.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/login_controller.dart';

class LoginFormView extends GetView<LoginController> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Your Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FormBuilder(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                decoration: authInputDecoration(context).copyWith(
                  labelText: 'Email',
                  filled: true,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'password',
                decoration: authInputDecoration(context).copyWith(
                  labelText: 'Password',
                  filled: true,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.minLength(context, 6),
                ]),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.indigo,
                onPressed: () {
                  if (controller.formKey.currentState?.saveAndValidate() ??
                      false) {
                    final keyField = controller.formKey.currentState;
                    _handleLogin(keyField!.fields['email']!.value.toString(),
                        keyField.fields['password']!.value.toString());
                  }
                },
                child: SizedBox(
                    width: double.infinity,
                    child:
                        'Login Account'.text.color(Colors.white).alignCenter),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin(String email, String password) {
    authController.loginUser(email, password);
  }
}
