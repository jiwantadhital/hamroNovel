import 'package:books/app/app.dart';
import 'package:books/firebase_options.dart';
import 'package:books/notification/local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  	print(message.data.toString());
 	print(message.notification!.title);
	}
Future<void> main() async{
  runApp( MyApp()); 
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
  );
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
     final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    		final token = await _fcm.getToken();
        print(token);
}

