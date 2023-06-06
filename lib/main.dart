import "dart:async";
import "dart:developer";

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:hashtag_mqtt/core/utils/index.dart';

import 'app.dart';

Future<void> initServices() async {
  ConnectivityUtil.configureConnectivityStream();

  await Future.wait(
    <Future<dynamic>>[
      FirebaseUtil.instance.firebaseConfigurations(),
      StorageUtil.init(),
    ],
  );
}

Future<void> main() async {
  runZonedGuarded<Future<void>>(
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      debugPrint = (String? message, {int? wrapWidth}) {
        if (kDebugMode) {
          log(message.toString());
        }
      };

      await initServices();

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
            (_) {
          runApp(
            const HashTagApp(),
          );
        },
      );
    },
        (Object error, StackTrace stack) {
      debugPrint("AppError: $error\nStackTrace: $stack");
      FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
}
