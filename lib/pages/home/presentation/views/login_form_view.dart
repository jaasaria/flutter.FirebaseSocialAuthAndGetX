import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/entity/error_model.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper_view.dart';
import 'package:getx_main_example/routes/app_pages.dart';

class LoginFormView extends StatefulWidget {
  @override
  _LoginFormViewState createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final _formKey = GlobalKey<FormBuilderState>();
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initialValue();
    });
  }

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
            key: _formKey,
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
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final keyField = _formKey.currentState;
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

  void initialValue() {
    _formKey.currentState?.patchValue({
      'email': 'asaria.ja@gmail.com',
      'password': '123456',
    });
  }

  void _handleLogin(String email, String password) {
    showDialogHelper();

    controller.loginUser(email, password).then((value) {
      Get.offAllNamed(Routes.AUTH);
      showSnackbarSuccess();
    }).onError((error, stackTrace) {
      showSnackbarFail(ErrorModel(error.toString()));
    }).whenComplete(() => closeDialogHelper());
  }
}
