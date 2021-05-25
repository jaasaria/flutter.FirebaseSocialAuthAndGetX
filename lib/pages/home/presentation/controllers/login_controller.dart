import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void onReady() {
    formKey.currentState?.patchValue({
      'email': 'test@gmail.com',
      'password': '123456',
    });

    super.onReady();
  }
}
