import "dart:io";

import 'package:connectivity_plus/connectivity_plus.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:hashtag_mqtt/core/base/index.dart';
import 'package:hashtag_mqtt/core/theme/index.dart';
import 'package:hashtag_mqtt/core/utils/index.dart';
import 'package:hashtag_mqtt/features/splash/index.dart';
import 'package:hashtag_mqtt/routes/index.dart';
import 'package:hashtag_mqtt/ui/widgets/index.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashController extends BaseRepositoryController<SplashRepository, SplashProvider, dynamic> {
  SplashController() : super(repository: SplashRepository());

  Future<void> _init() async {
    await Get.offAllNamed(AppRoutes.LOCATION);
  }

  void _updateButtonPressed() {
    try {
      if (Platform.isAndroid) {
        launchUrl(Uri.parse(GlobalVariables.firebase.playStoreUrl));
      } else {
        launchUrl(Uri.parse(GlobalVariables.firebase.appStoreUrl));
      }
    } catch (e) {
      debugPrint("LaunchStoreUrlError: $e");
    }
  }

  void _showRequiredDialog() {
    SnackbarToastUtil.showDialog(
      onWillPop: () async => false,
      barrierDismissible: false,
      title: "updated.dialog.title".tr,
      titlePadding: const EdgeInsets.only(top: 20),
      content: Text(
        "updated.dialog.description".tr,
        style: const TextStyle(
          color: ThemeColors.primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      contentPadding: const EdgeInsets.all(24),
      confirm: BaseButton(
        key: const Key("force_update_dialog_update_button"),
        backgroundColor: ThemeColors.primaryColor,
        borderRadius: 8,
        text: "updated.dialog.update".tr,
        onPressed: _updateButtonPressed,
      ),
    );
  }

  void _showNonRequiredDialog() {
    SnackbarToastUtil.showDialog(
      onWillPop: () async => false,
      barrierDismissible: false,
      title: "updated.dialog.title".tr,
      titlePadding: const EdgeInsets.only(top: 20),
      content: Text(
        "updated.dialog.description".tr,
        style: const TextStyle(
          color: ThemeColors.primaryTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      contentPadding: const EdgeInsets.all(24),
      cancel: BaseButton(
        key: const Key("force_update_dialog_continue_button"),
        backgroundColor: ThemeColors.thirdColor,
        borderRadius: 8,
        text: "updated.dialog.continue".tr,
        onPressed: _init,
      ),
      confirm: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: BaseButton(
          key: const Key("force_update_dialog_update_button"),
          backgroundColor: ThemeColors.primaryColor,
          borderRadius: 8,
          text: "updated.dialog.update".tr,
          onPressed: _updateButtonPressed,
        ),
      ),
    );
  }

  Future<bool> _connectivityCheck() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      return true;
    } else {
      await ConnectionNotFound.go(restartRequired: true);
      return false;
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    TranslationUtil.setLocale();

    final bool isConnected = await _connectivityCheck();

    if (GlobalVariables.app.restartRequired || !isConnected) {
      await ConnectionNotFound.go(restartRequired: true);
    }

    bool versionCheck = false;

    if (Platform.isAndroid) {
      versionCheck = await VersionCheckHelper.checkVersionByString(GlobalVariables.firebase.androidAppVersion);
    } else if (Platform.isIOS || Platform.isMacOS) {
      versionCheck = await VersionCheckHelper.checkVersionByString(GlobalVariables.firebase.iosAppVersion);
    }

    if (versionCheck) {
      _init();
    } else {
      if (GlobalVariables.firebase.forceUpdate == true) {
        _showRequiredDialog();
      } else {
        _showNonRequiredDialog();
      }
    }
  }
}
