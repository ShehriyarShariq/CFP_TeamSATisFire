import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'injection_container.dart' as di;

Future<dynamic> showNotification(Map<String, dynamic> message) async {
  FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidSettings =
      new AndroidInitializationSettings("@mipmap/ic_launcher");
  _localNotificationsPlugin.initialize(new InitializationSettings(
      android: androidSettings, iOS: new IOSInitializationSettings()));

  if (message.containsKey('notification')) {
    AndroidNotificationDetails androidNotifDetails =
        new AndroidNotificationDetails("channelId", "NOTIFICATION", "GENERAL");
    await _localNotificationsPlugin.show(
        0,
        message['notification']['title'],
        message['notification']['body'],
        NotificationDetails(
            android: androidNotifDetails, iOS: new IOSNotificationDetails()));
  }
  return Future<void>.value();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SATisFire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(),
    );
  }
}
