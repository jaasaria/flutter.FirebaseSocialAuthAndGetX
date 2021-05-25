import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/entity/failure.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/login_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper.dart';
import 'package:getx_main_example/routes/app_pages.dart';

class LoginFormView extends GetView<LoginController> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Your Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'email',
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.minLength(context, 6),
                  ]),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (controller.formKey.currentState?.saveAndValidate() ??
                        false) {
                      final keyField = controller.formKey.currentState;
                      _handleLogin(keyField!.fields['email']!.value.toString(),
                          keyField.fields['password']!.value.toString());
                    }
                    // print(_formKey.currentState?.value);
                  },
                  child: const Text('Login Account',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(String email, String password) {
    authController.loginUser(email, password);
  }
}
