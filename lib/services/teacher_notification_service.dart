import '../mock/mock_student_data.dart';

class TeacherNotificationService {
  void sendNotification({
    required String className,
    required String subject,
    required String message,
    required String notifyType,
    required List<String> selectedStudents,
  }) {
    final recipients = notifyType == "Whole Class"
        ? mockStudents.entries
            .where((e) => e.value["class"] == className)
            .map((e) => e.key)
            .toList()
        : selectedStudents;

    for (var studentId in recipients) {
      mockStudentNotifications[studentId] ??= [];

      mockStudentNotifications[studentId]!.add({
        "class": className,
        "subject": subject,
        "message": message,
        "date": DateTime.now().toString(),
      });
    }
  }
  List<Map<String, dynamic>> getStudentsByClass(String className) {
    return mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((e) => {
              "enrollment": e.key,
              ...e.value,
            })
        .toList();
  }
}
