import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashtag_mqtt/core/app/strings.dart';
import 'package:hashtag_mqtt/core/utils/index.dart';
import 'package:hashtag_mqtt/firebase_options.dart';

class FirebaseUtil {
  const FirebaseUtil();

  static const FirebaseUtil instance = FirebaseUtil();

  /*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint('Handling a background notification: ${message.messageId}');
  }*/

  Future<void> firebaseConfigurations() async {
    await _initializeApp();

    await Future.wait(
      <Future<dynamic>>[
        _firebaseAnalytics(),
        _firebaseMessaging(),
        _firebaseDatabase(),
        _firebaseRemoteConfig(),
      ],
    );
  }

  Future<void> _initializeApp() async {
    GlobalVariables.firebase.firebaseApp = await Firebase.initializeApp(
      name: AppStrings.firebaseAppName,
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _firebaseAnalytics() async {
    GlobalVariables.firebase.firebaseAnalytics = FirebaseAnalytics.instance;
    GlobalVariables.firebase.firebaseObserver = FirebaseAnalyticsObserver(analytics: GlobalVariables.firebase.firebaseAnalytics);
  }

  Future<void> _firebaseMessaging() async {
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
    });

    GlobalVariables.firebase.fcmToken = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: ${GlobalVariables.firebase.fcmToken}");
  }

  Future<void> _firebaseDatabase() async {
    GlobalVariables.firebase.firebaseDatabase = FirebaseDatabase.instanceFor(app: GlobalVariables.firebase.firebaseApp);
    GlobalVariables.firebase.firebaseDatabaseRef = GlobalVariables.firebase.firebaseDatabase.ref();
  }

  Future<void> _firebaseRemoteConfig() async {
    final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(milliseconds: 1),
          minimumFetchInterval: const Duration(milliseconds: 1),
        ),
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 200));

      final bool _updated = await _remoteConfig.fetchAndActivate();
      debugPrint("${_updated ? "new" : "old"}RemoteConfig: ${_remoteConfig.getAll().entries.map((MapEntry<String, RemoteConfigValue> entry) => "${entry.key}: ${entry.value.asString().toString()}")}");

      GlobalVariables.firebase.androidAppVersion = _remoteConfig.getValue('app_version_android').asString();
      GlobalVariables.firebase.iosAppVersion = _remoteConfig.getValue('app_version_ios').asString();
      GlobalVariables.firebase.forceUpdate = _remoteConfig.getValue('force_update').asBool();
      GlobalVariables.firebase.playStoreUrl = _remoteConfig.getValue('play_store_url').asString();
      GlobalVariables.firebase.appStoreUrl = _remoteConfig.getValue('app_store_url').asString();
    } catch (e) {
      debugPrint("FirebaseError: ${e.toString()}");
      GlobalVariables.app.restartRequired = true;
    }
  }
}
