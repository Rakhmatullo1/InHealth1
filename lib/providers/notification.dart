import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    AndroidInitializationSettings settings =
        const AndroidInitializationSettings('waterbottle');
    var initializationSettings = InitializationSettings(android: settings);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails(String? icon) {
    return NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max, icon: icon,),
    );
  }

  Future sendNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      String? icon}) async {
    await notificationsPlugin.show(
        id, title, body, notificationDetails('$icon'));
  }
}
