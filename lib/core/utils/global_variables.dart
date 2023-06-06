import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class GlobalVariables {
  static _App app = _App();
  static _Firebase firebase = _Firebase();
  static _Media media = _Media();
}

class _App {
  bool restartRequired = false;
  final Dio dio = Dio();
}

class _Firebase {
  late final FirebaseApp firebaseApp;
  late final FirebaseAnalytics firebaseAnalytics;
  late final FirebaseAnalyticsObserver firebaseObserver;
  late final FirebaseDatabase firebaseDatabase;
  late final DatabaseReference firebaseDatabaseRef;
  late final String? fcmToken;
  late final String androidAppVersion;
  late final String playStoreUrl;
  late final String iosAppVersion;
  late final String appStoreUrl;
  late final bool forceUpdate;
}

class _Media {
  String get appIconPath => "assets/app/icon.svg";
  String get appLogoPath => "assets/app/logo.svg";
  String get loadingOverlayPath => "assets/app/loading_overlay.svg";
  String get loadingIconPath => "assets/app/icon_color.svg";
}
