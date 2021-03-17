import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification notification = message?.notification;
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  if (notification != null) {
    print('Handling a background message ${message.messageId}');
  }
}

const channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

final initializationSettingsIOS = IOSInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) =>
        showLocalNotification(id, title, body, payload));

showLocalNotification(int id, String title, String body, String payload) {
  flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            priority: Priority.max,
            importance: Importance.max,
          ),
          iOS: IOSNotificationDetails()));
}

class FCM {
  var messaging = FirebaseMessaging.instance;

  final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  doInitializeFCM() async {
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectLocalNotifications);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var notification = message.notification;
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        showLocalNotification(
          notification.hashCode,
          notification.title,
          notification.body,
          notification.bodyLocKey,
        );
        print('Message also contained a notification: ${message.notification}');
      }
    });

    //when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var notification = message?.notification;

      print("onMessageOpenedApp ");
      if (notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future onSelectLocalNotifications(String payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
