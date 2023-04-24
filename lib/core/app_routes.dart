import 'package:auth_manager/views/change_password_view.dart';
import 'package:auth_manager/views/home_view.dart';
import 'package:auth_manager/views/login_view.dart';
import 'package:auth_manager/views/my_reservations_view.dart';
import 'package:auth_manager/views/service_details_view.dart';
import 'package:get/get.dart';

import '../splash_view.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => SplashView()),
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/home', page: () => HomeView()),
    GetPage(name: '/service-details', page: () => ServiceDetailsView()),
    GetPage(name: '/change-password', page: () => ChangePasswordView()),
    GetPage(name: '/my-reservations', page: () => MyReservationsView())
  ];
}
