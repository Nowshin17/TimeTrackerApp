import 'dart:io';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:flutter_push_notifications/utils/download_util.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;




Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
   'your_channel_id', // Replace with your channel ID
    'Your channel name', // Replace with your channel name
   // 'Your channel description', // Replace with your channel description
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Hello, there!', // Notification title
    'This is your notification message.', // Notification content
    platformChannelSpecifics,
    payload: 'item x',
  );
}

Future<void>  showNotification1(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
   // 'your_channel_id', // Replace with your channel ID
    'Your channel name', // Replace with your channel name
    'Your channel description', // Replace with your channel description
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Hello, there!', // Notification title
    'This is your notification message.', // Notification content
    platformChannelSpecifics,
    payload: 'item x',
  );
}



class NotificationService {
  NotificationService();

  static final _localNotifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  static NotificationDetails notificationDetails()
  {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        channelDescription:

        'channel id',
        'channel name',
     'channel description',
        importance: Importance.max,
      ),
      //iOS: IOSNotificationDetails(),
    );
  }



static Future showNotification(
  {
              int id = 0,
              String? title,
              String? body,
              String? payload,

          }) async => _localNotifications.show(
           id = 0,
         title,
          body,
    await notificationDetails(),
    payload: payload,
          );

  // Future<void> initializePlatformNotifications() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //   AndroidInitializationSettings('ic_stat_justwater');
  //   //
  //   // final IOSInitializationSettings initializationSettingsIOS =
  //   // IOSInitializationSettings(
  //   //     requestSoundPermission: true,
  //   //     requestBadgePermission: true,
  //   //     requestAlertPermission: true,
  //   //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //
  //   final InitializationSettings initializationSettings =
  //   InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //   );
  //
  //   await _localNotifications.initialize(initializationSettings,
  //       onSelectNotification: selectNotification);
  // }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }
}