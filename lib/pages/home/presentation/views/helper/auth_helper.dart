import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/entity/failure.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/user_controller.dart';

void showSnackbarSuccess() {
  if (Get.isSnackbarOpen == false) {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      final String? name = Get.find<UserController>().user?.name.toString();
      Get.snackbar(
          'Successfully Login:', "Welcome back: ${name?.toUpperCase()}");
    });
  }
}

void showSnackbarFail(Failure error) {
  if (Get.isSnackbarOpen == true) {
    Get.back();
  }
  if (Get.isDialogOpen == true) {
    Get.back();
  }
  Get.snackbar(
    'Something went wrong!',
    error.message,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 5),
  );
}

void showDialogHelper() {
  Get.defaultDialog(
      title: 'Loading',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: 20,
          ),
          Text('Please wait... '),
        ],
      ),
      barrierDismissible: false);
}

void closeDialogHelper() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}

InputDecoration authInputDecoration(BuildContext context) {
  return InputDecoration(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Theme.of(context).primaryColor)),
  );
}
