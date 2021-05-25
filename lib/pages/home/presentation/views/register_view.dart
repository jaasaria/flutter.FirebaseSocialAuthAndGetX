import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/register_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper.dart';
import 'package:textless/textless.dart';

class RegisterView extends GetView<RegisterController> {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Your Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FormBuilder(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                FormBuilderTextField(
                  name: 'full_name',
                  decoration: authInputDecoration(context).copyWith(
                    labelText: 'Fullname',
                    filled: true,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  keyboardType: TextInputType.emailAddress,
                  name: 'email',
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
                Obx(() => FormBuilderTextField(
                      name: 'password',
                      decoration: authInputDecoration(context).copyWith(
                        labelText: 'Password',
                        filled: true,
                      ),
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
                      decoration: authInputDecoration(context).copyWith(
                        labelText: 'Confirm Password',
                        filled: true,
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
                    activeColor: Colors.indigo,
                    title: 'Show Password?'.cap.alignEnd,
                    value: controller.obsecure.value,
                    onChanged: (bool val) {
                      controller.handleObsecure();
                    })),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.indigo),
                  onPressed: () {
                    if (controller.formKey.currentState?.saveAndValidate() ??
                        false) {
                      controller.handleCreateUser();
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: 'Register Account'.text.alignCenter,
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Utility Tools'.text,
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.formKey.currentState?.reset();
                          },
                          child: SizedBox(
                              width: double.infinity,
                              child: 'Reset Form'
                                  .text
                                  .color(Colors.white)
                                  .alignCenter),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.initialValue();
                          },
                          child: SizedBox(
                              width: double.infinity,
                              child: 'Generate Data'
                                  .text
                                  .color(Colors.white)
                                  .alignCenter),
                        ),
                      ],
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
}
