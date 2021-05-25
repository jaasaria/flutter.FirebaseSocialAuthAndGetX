import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/views/auth_view.dart';
import 'package:getx_main_example/pages/home/presentation/views/login_form_view.dart';
import 'package:getx_main_example/pages/home/presentation/views/main_view.dart';

import '../pages/home/bindings/home_binding.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: Routes.AUTH,
      page: () => AuthView(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginFormView(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainView(),
    ),
  ];
}
