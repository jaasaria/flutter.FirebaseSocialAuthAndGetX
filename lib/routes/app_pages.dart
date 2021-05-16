import 'package:get/get.dart';
import 'package:getx_main_example/pages/home/presentation/views/auth_view.dart';
import 'package:getx_main_example/pages/home/presentation/views/login_view.dart';
import 'package:getx_main_example/pages/home/presentation/views/main_view.dart';

import '../pages/home/bindings/home_binding.dart';
import '../pages/home/presentation/views/country_view.dart';
import '../pages/home/presentation/views/details_view.dart';
import '../pages/home/presentation/views/home_view.dart';

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
      page: () => LoginView(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainView(),
    ),
    GetPage(
        name: Routes.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        children: [
          GetPage(
            name: Routes.COUNTRY,
            page: () => CountryView(),
            children: [
              GetPage(
                name: Routes.DETAILS,
                page: () => DetailsView(),
              ),
            ],
          ),
        ]),
  ];
}
