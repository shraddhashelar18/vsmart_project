import '../models/notification_model.dart';

class NotificationService {
  static Future<List<NotificationModel>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      NotificationModel(
        title: "CT-1 Declared",
        message: "Your Class Test 1 marks are available.",
        date: "12 Mar 2026",
      ),
      NotificationModel(
        title: "Attendance Alert",
        message: "Attendance below 75%. Please improve.",
        date: "10 Mar 2026",
      ),
      NotificationModel(
        title: "Final Result",
        message: "Semester 2 result declared.",
        date: "01 Mar 2026",
      ),
    ];
  }
}
