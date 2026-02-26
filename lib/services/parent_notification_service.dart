import '../mock/mock_notification_data.dart';

class ParentNotificationService {
  static Future<List<Map<String, dynamic>>> fetchParentNotifications(
      List<String> enrollments) async {
    await Future.delayed(const Duration(milliseconds: 300));

    List<Map<String, dynamic>> allNotifications = [];

    for (var enrollment in enrollments) {
      final studentNotifs = mockNotificationsData[enrollment] ?? [];

      allNotifications.addAll(studentNotifs);
    }

    // Sort latest first (string date works if yyyy-MM-dd)
    allNotifications.sort(
      (a, b) => b["date"].compareTo(a["date"]),
    );

    return allNotifications;
  }
}
