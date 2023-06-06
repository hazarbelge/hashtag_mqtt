import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import 'package:hashtag_mqtt/core/theme/index.dart';
import 'package:hashtag_mqtt/core/utils/index.dart';
import 'package:hashtag_mqtt/features/splash/index.dart';
import 'package:hashtag_mqtt/ui/widgets/custom_widgets/index.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      key: Key("splash_screen_scaffold"),
      colors: <Color>[
        ThemeColors.secondaryColor,
        ThemeColors.primaryColor,
      ],
      child: Center(
        key: Key("splash_screen_center_widget"),
        child: SplashScreenLogo(
          key: Key("splash_screen_logo_widget"),
        ),
      ),
    );
  }
}

class SplashScreenLogo extends StatelessWidget {
  const SplashScreenLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Builder(
          builder: (BuildContext context) {
            return SizedBox(
              height: 225,
              width: 250,
              child: SvgPicture.asset(GlobalVariables.media.loadingIconPath),
            );
          },
        ),
      ),
    );
  }
}
