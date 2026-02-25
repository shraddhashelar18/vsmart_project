import '../mock/mock_student_data.dart';
import '../screens/student/models/notification_model.dart'

class NotificationService {
  static Future<List<NotificationModel>> fetchNotifications(
      String enrollment) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final rawList = mockStudentNotifications[enrollment] ?? [];

    return rawList
        .map((n) => NotificationModel(
              title: n["title"],
              message: n["message"],
              date: n["date"],
            ))
        .toList();
  }
}
