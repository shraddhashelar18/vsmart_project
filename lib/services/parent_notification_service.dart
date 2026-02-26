import '../mock/mock_student_data.dart';

class ParentNotificationService {
  static Future<List<Map<String, dynamic>>> fetchParentNotifications(
      List<String> enrollments) async {
    await Future.delayed(const Duration(milliseconds: 300));

    List<Map<String, dynamic>> allNotifications = [];

    for (var enrollment in enrollments) {
      final studentNotifs = mockStudentNotifications[enrollment] ?? [];

      allNotifications.addAll(studentNotifs);
    }

    // Sort latest first
    allNotifications.sort(
      (a, b) => b["date"].compareTo(a["date"]),
    );

    return allNotifications;
  }
}
