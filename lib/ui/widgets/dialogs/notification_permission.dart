import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hashtag_mqtt/core/theme/index.dart';
import 'package:hashtag_mqtt/ui/widgets/index.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermission extends StatelessWidget {
  const NotificationPermission({
    Key? key,
  }) : super(key: key);

  static Future<void> show() async {
    await showDialog(
      context: Get.overlayContext ?? Get.context!,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return const NotificationPermission();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: _height * 0.175),
          SvgPicture.asset("assets/welcome/notification.svg"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: _width * 0.15),
            child: Text(
              "notification.permission.title".tr,
              style: TextStyles.titleBold,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: _width * 0.07),
            child: Text(
              "notification.permission.description".tr,
              style: TextStyles.paragraph.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(flex: 2),
          CustomElevatedButton(
            text: "notification.permission.button".tr,
            textStyle: TextStyles.buttonText,
            backgroundColor: Colors.white,
            onPressed: () async {
              bool _canContinue = false;

              if (!await Permission.notification.isGranted) {
                await Permission.notification.request();
                _canContinue = await Permission.notification.isGranted;
              } else {
                _canContinue = true;
              }

              if (_canContinue) {
                Get.back();
              }
            },
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: Get.back,
            child: Text(
              "not.now".tr,
              style: TextStyles.buttonText.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
