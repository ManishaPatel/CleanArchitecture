import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    try {
      // Initialize local notifications (works without Firebase)
      const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings iosSettings =  DarwinInitializationSettings();
      const InitializationSettings initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (details) {
        },
      );

      _isInitialized = true;
      print('Local notifications initialized successfully');

      try {} catch (e) {
        print('Firebase not configured: $e');
        print('App will work with local notifications only');
      }
    } catch (e) {
      print('Error initializing notifications: $e');
      // App will continue to work without notifications
    }
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    if (!_isInitialized) {
      print('Notifications not initialized');
      return;
    }

    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'employee_channel',
            'Employee Notifications',
            channelDescription: 'Notifications for employee management',
            importance: Importance.high,
            priority: Priority.high,
          );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

      const NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title,
        body,
        details,
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }
}
