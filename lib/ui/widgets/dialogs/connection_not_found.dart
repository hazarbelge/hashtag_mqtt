import "package:flutter/material.dart";
import "package:get/get.dart";

class ConnectionNotFound extends StatelessWidget {
  const ConnectionNotFound({
    Key? key,
    this.restartRequired = false,
  }) : super(key: key);

  final bool restartRequired;

  static Future<void> show({final bool restartRequired = false}) async {
    await showDialog(
      context: Get.overlayContext ?? Get.context!,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return ConnectionNotFound(
          restartRequired: restartRequired,
        );
      },
    );
  }

  static Future<void> go({final bool restartRequired = false}) async {
    await Get.to(
      () => ConnectionNotFound(
        restartRequired: restartRequired,
      ),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(color: Get.theme.primaryColor),
              const SizedBox(height: 20),
              Text(
                restartRequired ? "restart.required".tr : "no.internet".tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
