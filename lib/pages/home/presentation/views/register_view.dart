import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/register_controller.dart';
import 'package:textless/textless.dart';

class RegisterView extends GetView<RegisterController> {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Your Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'full_name',
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  keyboardType: TextInputType.emailAddress,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                ),
                const SizedBox(height: 10),
                Obx(() => FormBuilderTextField(
                      name: 'password',
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: !controller.obsecure.value,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.minLength(context, 6),
                      ]),
                    )),
                const SizedBox(height: 10),
                Obx(() => FormBuilderTextField(
                      name: 'confirm_password',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      obscureText: !controller.obsecure.value,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.minLength(context, 6),
                        (val) {
                          if (val !=
                              controller.formKey.currentState
                                  ?.fields['password']?.value) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ]),
                    )),
                Obx(() => SwitchListTile(
                    title: 'Show Password?'.cap.alignEnd,
                    value: controller.obsecure.value,
                    onChanged: (bool val) {
                      controller.handleObsecure();
                    })),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState?.saveAndValidate() ??
                        false) {
                      final keyField = controller.formKey.currentState;

                      controller.handleCreateUser();
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: 'Register Account'.text.alignCenter,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        controller.formKey.currentState?.reset();
                      },
                      child: const Text('Reset Form',
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.initialValue();
                      },
                      child: const Text('Generate',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void _handleCreateUser(String email, String password, String name) {
  //   showDialogHelper();

  //   controller
  //       .createUser(name: name, email: email, password: password)
  //       .then((value) {
  //     showSnackbarSuccess();
  //     Get.offAllNamed(Routes.AUTH);
  //   }).onError((error, stackTrace) {
  //     showSnackbarFail(ErrorModel(error.toString()));
  //   }).whenComplete(() {
  //     closeDialogHelper();
  //   });
  // }
}
