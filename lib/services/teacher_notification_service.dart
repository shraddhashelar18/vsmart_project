import '../mock/mock_student_data.dart';
import '../mock/mock_parent_data.dart';

class TeacherNotificationService {
  void sendNotification({
    required String className,
    required String subject,
    required String message,
    required String notifyType,
    required List<String> selectedRecipients,
  }) {
    List<String> recipients = [];

    if (notifyType == "wholeStudents") {
      recipients = mockStudents.entries
          .where((e) => e.value["class"] == className)
          .map((e) => e.key)
          .toList();
    } else if (notifyType == "wholeParents") {
      recipients = getParentsByClass(className)
          .map((e) => e["parentPhone"] as String)
          .toList();
    } else if (notifyType == "selectedStudents" ||
        notifyType == "selectedParents") {
      recipients = selectedRecipients;
    }

    for (var id in recipients) {
      if (notifyType == "wholeParents" || notifyType == "selectedParents") {
        mockParentNotifications[id] ??= [];
        mockParentNotifications[id]!.add({
          "title": "Message from $subject",
          "message": message,
          "date": DateTime.now().toString(),
        });
      } else {
        mockStudentNotifications[id] ??= [];
        mockStudentNotifications[id]!.add({
          "title": "Message from $subject",
          "message": message,
          "date": DateTime.now().toString(),
        });
      }
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

  List<Map<String, dynamic>> getParentsByClass(String className) {
    final studentIds = mockStudents.entries
        .where((e) => e.value["class"] == className)
        .map((e) => e.key)
        .toList();

    return mockParents.entries
        .where((parent) => (parent.value["children"] as List)
            .any((childId) => studentIds.contains(childId)))
        .map((e) => {
              "parentPhone": e.key,
              ...e.value,
            })
        .toList();
  }
}
