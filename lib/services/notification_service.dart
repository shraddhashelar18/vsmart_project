import '../mock/mock_student_data.dart';
import '../screens/student/models/notification_model.dart';

class NotificationService {
  static Future<List<NotificationModel>> fetchNotificationsByEmail(
      String email) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final studentEntry = mockStudents.entries.firstWhere(
      (e) => e.value["email"] == email,
      orElse: () => throw Exception("Student not found"),
    );

    final enrollment = studentEntry.key;

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
