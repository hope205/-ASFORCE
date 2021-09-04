import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/rxdart.dart';

class LocalNotifyManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  InitializationSettings initializationSettings;

  BehaviorSubject<RecievedNotification>
      get didRecievedLocalNotificationSubject =>
          BehaviorSubject<RecievedNotification>();

  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    //if the platform is ios, it executes this line
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initialisePlatform();
  }

  //this is to request the permission of the ios user
  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  initialisePlatform() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_notf_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
        RecievedNotification notification = RecievedNotification(
            id: id, title: title, body: body, payload: payload);
        didRecievedLocalNotificationSubject.add(notification);
      },
    );

    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  setOnNotificationRecieve(Function onNotificationReceived) {
    didRecievedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationReceived(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification({String message, String item}) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      'CHANNEL_DESCRIPTION',
      importance: Importance.max,
      priority: Priority.high,
    );
    var IOSChannelSpecifics = IOSNotificationDetails();
    var PlatformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      iOS: IOSChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        0, item, message, PlatformChannelSpecifics,
        payload: 'Test payload');
  }
}

LocalNotifyManager notificationPlugin = LocalNotifyManager.init();

class RecievedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  RecievedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
