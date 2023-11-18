

import 'dart:convert';

import 'package:chitrai/screens/Artpage.dart';

import 'package:chitrai/screens/home.dart';
import 'package:chitrai/screens/propage.dart';
import 'package:chitrai/screens/splashscreen.dart';
import 'package:chitrai/screens/try.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'package:shared_preferences/shared_preferences.dart';



import 'package:http/http.dart' as http;

void main() async {

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Set portrait orientation
    DeviceOrientation.portraitDown, // Set portrait orientation upside down
  ]);



  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
      MyApp( )
  );
}

class MyApp extends StatelessWidget {

   MyApp({Key? key,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:home()


     ,

      debugShowCheckedModeBanner:false ,
    );
  }
}


/*

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  // Initialize the notification plugin
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Create a notification channel (required for Android 8.0 and above)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'reel_alerts',
    'Reel Alerts',
   // 'Notification alerts',
    importance: Importance.high,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Show a persistent notification with a small icon and a message
  const AndroidNotificationDetails notificationDetails = AndroidNotificationDetails(
    'reel_alert_notification',
    'Reel Alert Notification',
  //  'Notification for Reel Alerts',
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
    styleInformation: BigTextStyleInformation(''),
    largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
   // smallIcon: const DrawableResourceAndroidBitmap('app_icon'),
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: notificationDetails,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    'Reel Alert',
    'Time is up. Please stop watching Reels and do your work.',
    platformChannelSpecifics,
  );

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reel Alert Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Reel Alert Demo'),
        ),
        body: Center(
          child: const Text('Welcome to the Reel Alert Demo'),
        ),
      ),
    );
  }
}

*/
