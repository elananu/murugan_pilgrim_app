// lib/services/notification_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzData;
import 'festival_calendar.dart';
import 'dart:typed_data';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'murugan_festivals';
  static const _channelName = 'Festival Reminders';
  static const _channelDesc = 'Alarm notifications for all Murugan festivals';

  static const _prefEnabled = 'notifications_enabled';
  static const _prefScheduledYear = 'alarms_scheduled_for_year';

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tzData.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundTap,
    );

    final ap = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await ap?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDesc,
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        enableLights: true,
      ),
    );

    _initialized = true;

    await _autoRefreshForNewYear();
  }

  static void _onTap(NotificationResponse response) {}

  @pragma('vm:entry-point')
  static void _onBackgroundTap(NotificationResponse response) {}

  Future<void> _autoRefreshForNewYear() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_prefEnabled) ?? false;
    if (!enabled) return;

    final scheduledYear = prefs.getInt(_prefScheduledYear) ?? 0;
    final currentYear = DateTime.now().year;

    if (scheduledYear != currentYear) {
      await _scheduleAll();
      await prefs.setInt(_prefScheduledYear, currentYear);
    }
  }

  Future<void> requestPermission() async {
    final ap = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await ap?.requestNotificationsPermission();
    await ap?.requestExactAlarmsPermission();
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefEnabled, enabled);

    if (enabled) {
      await requestPermission();
      await _scheduleAll();
      await prefs.setInt(_prefScheduledYear, DateTime.now().year);
    } else {
      await _plugin.cancelAll();
      await prefs.remove(_prefScheduledYear);
    }
  }

  Future<void> _scheduleAll() async {
    final location = tz.getLocation('Asia/Kolkata');
    final now = tz.TZDateTime.now(location);

    await _plugin.cancelAll();

    final festivals = FestivalCalendar.getUpcoming();

    for (final festival in festivals) {
      final festivalTime = tz.TZDateTime.from(festival.date, location);

      if (festivalTime.isBefore(now)) continue;

      // Alarm A: On the festival day at 6:00 AM IST
      try {
        await _plugin.zonedSchedule(
          festival.id,
          '🙏 ${festival.emoji} ${festival.name} – Today!',
          festival.description,
          festivalTime,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channelId,
              _channelName,
              channelDescription: _channelDesc,
              importance: Importance.max,
              priority: Priority.max,
              fullScreenIntent: true,
              playSound: true,
              enableVibration: true,
              vibrationPattern: Int64List.fromList([0, 500, 200, 500]),
              color: const Color(0xFF9C27B0),
              largeIcon:
                  const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              styleInformation: BigTextStyleInformation(
                festival.description,
                contentTitle: '🙏 ${festival.emoji} ${festival.name} – Today!',
              ),
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: 'default',
              interruptionLevel: InterruptionLevel.timeSensitive,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: 'festival:${festival.id}:${festival.key}',
        );
      } catch (e) {
        debugPrint('Could not schedule alarm A for ${festival.name}: $e');
      }

      // Alarm B: 1 day before the festival at 6:00 AM IST
      final dayBefore = festivalTime.subtract(const Duration(days: 1));
      if (dayBefore.isAfter(now)) {
        try {
          await _plugin.zonedSchedule(
            festival.id + 100,
            '🔔 ${festival.emoji} ${festival.name} – Tomorrow!',
            'Plan your temple visit. ${festival.formattedDate} at 6 AM IST.',
            dayBefore,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channelId,
                _channelName,
                channelDescription: _channelDesc,
                importance: Importance.high,
                priority: Priority.high,
                playSound: true,
                enableVibration: true,
                color: const Color(0xFF9C27B0),
                largeIcon:
                    const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                interruptionLevel: InterruptionLevel.active,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            payload: 'reminder:${festival.id}:${festival.key}',
          );
        } catch (e) {
          debugPrint('Could not schedule alarm B for ${festival.name}: $e');
        }
      }
    }
  }

  Future<void> sendTestNotification() async {
    final upcoming = FestivalCalendar.getUpcoming();
    final next = upcoming.isNotEmpty ? upcoming.first : null;
    final nextText = next != null
        ? 'Next: ${next.emoji} ${next.name} on ${next.formattedDate}'
        : 'Festival dates loaded for this year.';

    await _plugin.show(
      9999,
      '✅ Festival alarms are ON!',
      nextText,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          importance: Importance.high,
          priority: Priority.high,
          color: const Color(0xFF9C27B0),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }

  Future<bool> isEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefEnabled) ?? false;
  }
}
