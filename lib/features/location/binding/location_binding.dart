import "package:get/get.dart";
import 'package:hashtag_mqtt/features/location/index.dart';

class HashTagBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      HashTagController(),
    );
  }
}
