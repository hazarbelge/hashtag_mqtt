import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hashtag_mqtt/core/utils/index.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  final FlutterErrorDetails errorDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(GlobalVariables.media.appLogoPath),
            const SizedBox(height: 50),
            Text(
              kDebugMode ? errorDetails.summary.toString() : "something.went.wrong".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kDebugMode ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "try.later".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
