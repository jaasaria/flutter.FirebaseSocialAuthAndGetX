import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/domain/entity/error_model.dart';
import 'package:getx_main_example/pages/home/presentation/controllers/auth_controller.dart';
import 'package:getx_main_example/pages/home/presentation/views/helper/auth_helper_view.dart';
import 'package:getx_main_example/routes/app_pages.dart';
import 'package:textless/textless.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool obscureText = false;
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
        title: const Text('Register Your Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _formKey,
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
                FormBuilderTextField(
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: !obscureText,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    // FormBuilderValidators.minLength(context, 6),
                  ]),
                ),
                const SizedBox(height: 10),
                FormBuilderTextField(
                  name: 'confirm_password',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Confirm Password',
                  ),
                  obscureText: !obscureText,
                  validator: FormBuilderValidators.compose([
                    (val) {
                      if (val !=
                          _formKey.currentState?.fields['password']?.value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ]),
                ),
                SwitchListTile(
                    title: 'Show Password?'.cap.alignEnd,
                    value: obscureText,
                    onChanged: (bool val) {
                      setState(() {
                        obscureText = val;
                      });
                    }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      child: const Text('Reset Form',
                          style: TextStyle(color: Colors.white)),
                    ),
                    MaterialButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        // if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final keyField = _formKey.currentState;
                        _handleCreateUser(
                            keyField!.fields['email']!.value.toString(),
                            keyField.fields['password']!.value.toString(),
                            keyField.fields['full_name']!.value.toString());
                        // }
                        // print(_formKey.currentState?.value);
                      },
                      child: const Text('Register Account',
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

  void initialValue() {
    _formKey.currentState?.patchValue({
      'full_name': 'john andrew asaria',
      'email': 'asaria.ja@gmail.com',
      'password': '123456',
      'confirm_password': '123456',
    });
  }

  void _handleCreateUser(String email, String password, String name) {
    showDialogHelper();

    controller
        .createUser(name: name, email: email, password: password)
        .then((value) {
      showSnackbarSuccess();
      Get.offAllNamed(Routes.AUTH);
    }).onError((error, stackTrace) {
      showSnackbarFail(ErrorModel(error.toString()));
    }).whenComplete(() {
      closeDialogHelper();
    });
  }
}
