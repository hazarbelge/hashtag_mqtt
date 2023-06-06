import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:hashtag_mqtt/core/utils/index.dart';

class TranslationUtil extends Translations {
  static TranslationUtil instance = TranslationUtil();

  static Locale? locale = getLocale() ?? Get.deviceLocale;
  static const Locale fallbackLocale = Locale("tr");

  static List<String> items = <String>[];

  static void setLocale() {
    if (getLocale() == null && Get.deviceLocale == null) {
      debugPrint("LocaleFallback: ${TranslationUtil.fallbackLocale}");
      Get.updateLocale(TranslationUtil.fallbackLocale);
    } else {
      debugPrint("LocaleUpdate: ${Get.deviceLocale ?? getLocale()!}");
      Get.updateLocale(Get.deviceLocale ?? getLocale()!);
    }
    languageSave();
  }

  static void languageSave() {
    StorageUtil.write("language_code", Get.deviceLocale?.languageCode);
    StorageUtil.write("country_code", Get.deviceLocale?.countryCode);
    debugPrint("Locale ${Get.deviceLocale?.languageCode}_${Get.deviceLocale?.countryCode} is saved.");
  }

  static String? getLanguageCode() {
    return StorageUtil.read<String>("language_code");
  }

  static String? getCountryCode() {
    return StorageUtil.read<String>("country_code");
  }

  static Locale? getLocale() {
    final String? languageCode = getLanguageCode();
    final String? countryCode = getCountryCode();
    return languageCode != null && countryCode != null ? Locale(languageCode, countryCode) : Get.deviceLocale;
  }

  @override
  Map<String, Map<String, String>> get keys => const <String, Map<String, String>>{
        "tr": <String, String>{
          "distance.range": "Mesafe Aralığı",
          "almost.same.position": "Neredeyse Aynı Konumdasınız",
          "your.location": "Konumunuz dış daire üzerindeki bir noktadadır",
        },
        "en": <String, String>{
          "distance.range": "Distance Range",
          "almost.same.position": "You are almost in the same position",
          "your.location": "Your location is on a point outside the circle",
        },
  };
}
