import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin notifications =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(
      android: android,
    );

    await notifications.initialize(settings);

    await notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    debugPrint("✅ Notification Service Initialized");
  }

  Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'medication_channel',
      'Medication Reminders',
      channelDescription: 'Medication reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: android);

    await notifications.show(
      0,
      title,
      body,
      details,
    );
  }

  Future<void> scheduleMedicationNotification({
    required int id,
    required String medicine,
    required TimeOfDay time,
  }) async {
    final now = DateTime.now();

    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    final scheduledTZ = tz.TZDateTime.from(scheduled, tz.local);

    const android = AndroidNotificationDetails(
      'medication_channel',
      'Medication Reminders',
      channelDescription: 'Medication reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: android);

    try {
      await notifications.zonedSchedule(
        id,
        'Medication Reminder',
        'Time to take $medicine',
        scheduledTZ,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      final pending = await notifications.pendingNotificationRequests();

      debugPrint("Pending notifications: ${pending.length}");

      for (final n in pending) {
        debugPrint("ID: ${n.id} | Title: ${n.title}");
      }

      debugPrint("✅ Scheduled notification");
      debugPrint("ID: $id");
      debugPrint("Medicine: $medicine");
      debugPrint("Scheduled Time: $scheduledTZ");
    } catch (e, stackTrace) {
      debugPrint("❌ Scheduling failed");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> cancelNotification(int id) async {
    await notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await notifications.cancelAll();
  }
}