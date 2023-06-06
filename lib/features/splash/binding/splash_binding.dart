import "package:get/get.dart";
import 'package:hashtag_mqtt/features/splash/index.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(),
    );
  }
}
