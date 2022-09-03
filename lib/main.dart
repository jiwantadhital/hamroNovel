import 'package:books/app/app.dart';
import 'package:books/firebase_options.dart';
import 'package:books/notification/local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:shared_preferences/shared_preferences.dart';

  int number = 1;
Future<void> backgroundHandler(RemoteMessage message) async {
  	FlutterAppBadger.updateBadgeCount(number++);

	}
Future<void> main() async{
  runApp( MyApp()); 
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
  );
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
}

