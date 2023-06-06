import "package:get/get.dart";
import 'package:hashtag_mqtt/features/location/index.dart';
import 'package:hashtag_mqtt/features/splash/index.dart';
import 'package:hashtag_mqtt/routes/index.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashScreen>(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      preventDuplicates: true,
    ),
    GetPage<HashTagScreen>(
      name: AppRoutes.LOCATION,
      page: () => const HashTagScreen(),
      binding: HashTagBinding(),
      preventDuplicates: true,
    ),
  ];
}
