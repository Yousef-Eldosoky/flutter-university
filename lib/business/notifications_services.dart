import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize the local notifications system
  static Future<void> init() async {
    // Configure Android settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configure iOS settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    // Combine settings for both platforms
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize the local notifications plugin
    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Show a local notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_channel', // ID of the channel
      'Default Channel', // Name of the channel
      channelDescription: 'This channel is used for default notifications.',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Display the notification
    await _localNotificationsPlugin.show(
      id,
      title,
      body,
      platformDetails,
    );
  }

  /// Handle notification tap events
  static void _onNotificationTap(NotificationResponse response) {
    // Navigate to specific screen or perform actions
    // This can be linked to application status, missing documents, etc.
    print('Notification tapped: ${response.payload}');
  }
}
