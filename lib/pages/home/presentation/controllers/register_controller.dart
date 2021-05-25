import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/adapters/i_auth_repository.dart';
import 'package:getx_main_example/pages/home/domain/entity/failure.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper.dart';
import 'package:getx_main_example/routes/app_pages.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final IAuthRepository repository;
  Rx<bool> obsecure = true.obs;

  RegisterController({required this.repository});

  @override
  void onReady() {
    super.onReady();
    initialValue();
  }

  void handleObsecure() {
    obsecure.toggle();
  }

  void initialValue() {
    formKey.currentState?.patchValue({
      'full_name': 'test user name',
      'email': 'test@gmail.com',
      'password': '123456',
      'confirm_password': '123456',
    });
  }

  Future<void> handleCreateUser() async {
    try {
      final keyField = formKey.currentState;
      showDialogHelper();

      await repository.createUser(
          name: keyField!.fields['full_name']!.value.toString(),
          email: keyField.fields['email']!.value.toString(),
          password: keyField.fields['password']!.value.toString());

      showSnackbarSuccess();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      showSnackbarFail(Failure(e.toString()));
    } finally {
      closeDialogHelper();
    }
  }
}
