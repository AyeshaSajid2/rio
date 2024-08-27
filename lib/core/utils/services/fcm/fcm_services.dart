// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io' show Platform;

// import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmServices {
  // var fcmServerToken =
  //     "AAAAonkaQSg:APA91bEf4L6-ssXNlV6V3AEztDAWtrCDY7VWvEbwXc54UNN5YQEfnSiw6Z57U7CUeo9CH998zYL2VutUt830FNctT8JgNdAhckvjPCRcUfniL33gVLmSGPjk_WQpTnWqKIyKLh0-xGRh";

  // static getToken() {
  //   FirebaseMessaging.instance.getToken().then((value) {
  //     if (Platform.isAndroid) {
  //       currentUserAndroidToken = value!;
  //       currentUserIosToken = '';
  //     } else {
  //       currentUserAndroidToken = '';
  //       currentUserIosToken = value!;
  //     }
  //     log('FCM Token: $value');
  //   });
  // }

  // static subscribeTopic(String topicName) {
  //   FirebaseMessaging.instance.subscribeToTopic(topicName);
  // }

  // static fcmListen() {
  //   FirebaseMessaging.onMessage.listen((event) {
  //     log('Event: $event');
  //     var title = event.notification!.title.toString();
  //     log('Title: $title');
  //     var body = event.notification!.body.toString();
  //     log('Body: $body');
  //     FcmServices.showNotifications(title, body);
  //     HomeController homeController = Get.find<HomeController>();
  //     homeController.getUnAcknowledgeList();
  //   });
  // }

  // static Future backgroundMessage(RemoteMessage message) async {
  //   Firebase.initializeApp();
  //   FcmServices.showNotifications(
  //       message.notification!.title!, message.notification!.body!);
  //   // HomeController homeController = Get.find<HomeController>();
  //   // homeController.getUnAcknowledgeList();
  //   log('Message: $message');
  //   log('Title: ${message.notification!.title}');
  //   log('Body: ${message.notification!.body}');
  // }

  //show notification//
  static showNotifications(String title, String body, String payload) {
    FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();
    notificationsPlugin.initialize(
      InitializationSettings(
        android: const AndroidInitializationSettings("@mipmap/ic_notification"),
        iOS: DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {},
        ),
      ),
      onDidReceiveNotificationResponse: null,
      onDidReceiveBackgroundNotificationResponse: null,
    );
    notificationsPlugin.show(
        111,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "rio_notification",
            "rio_android",
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: payload);
  }

  // sendNotification({
  //   required String to,
  //   required String title,
  //   required String body,
  // }) async {
  //   final response = await Dio().post(
  //     'https://fcm.googleapis.com/fcm/send',
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key= $fcmServerToken',
  //       },
  //     ),
  //     data: jsonEncode({
  //       "to": to,
  //       "notification": {
  //         "title": title,
  //         "body": body,
  //       },
  //       // "data": {
  //       // "url": "<url of media image>",
  //       // "dl": "<deepLink action on tap of notification>"
  //       // }
  //     }),
  //   );

  //   var resCode = response.statusCode.toString();
  //   log("Notification StatusCode: $resCode");
  // }
}
