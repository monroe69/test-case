import 'package:get/get.dart';
import 'package:tes_api/view/Onboarding/onboarding.dart';
import 'package:tes_api/view/auth/Log-in.dart';
import 'package:tes_api/view/beranda/add_data.dart';
import 'package:tes_api/view/beranda/detail_data.dart';
import 'package:tes_api/view/beranda/tesmain.dart';

import 'routename.dart';

class TodoRoute {
  static const Home = routename.Home;
  static const Onboarding = '/Onboarding';
  static const login = '/log-in';
  static final page = [
    GetPage(
      name: routename.Home,
      page: () => beranda(),
    ),
    GetPage(name: '/log-in', page: () => Login()),
    GetPage(
      name: '/Onboarding',
      page: () => const boarding(),
    ),
    GetPage(
      name: '/add-data',
      page: () => const adddata(),
    ),
    GetPage(
      name: '/detail-data',
      page: () => const daetaildata(),
    )
  ];
}
