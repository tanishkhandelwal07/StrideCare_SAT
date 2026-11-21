import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../l10n/generated/app_localizations.dart';
import '../../storage/care_database.dart';

class MedicineReminders {
  static final plugin = FlutterLocalNotificationsPlugin();
  static Future<bool?>? initialization;
  static bool get supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
  static int notificationId(String id) => int.parse(id).remainder(2147483647);
  static Future<bool> schedule(MedicationLog m, AppLocalizations s) async {
    if (!supported || m.scheduledAt.isBefore(DateTime.now())) return false;
    try {
      await (initialization ??= plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
      ));
      final granted = defaultTargetPlatform == TargetPlatform.android
          ? await plugin
                .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin
                >()
                ?.requestNotificationsPermission()
          : await plugin
                .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin
                >()
                ?.requestPermissions(alert: true, sound: true, badge: false);
      if (granted != true) return false;
      await plugin.zonedSchedule(
        id: notificationId(m.id),
        title: s.medicine,
        body: m.medicineName,
        scheduledDate: tz.TZDateTime.from(m.scheduledAt, tz.UTC),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails('medicine', s.medicine),
          iOS: const DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> cancel(String id) async {
    if (supported) await plugin.cancel(id: notificationId(id));
  }
}
