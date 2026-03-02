import '../mock/mock_parent_data.dart';

class ParentNotificationService {
  static Future<List<Map<String, dynamic>>> fetchParentNotifications(
      String parentPhone) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final parentNotifs = mockParentNotifications[parentPhone] ?? [];

    // Sort latest first
    parentNotifs.sort(
      (a, b) => b["date"].compareTo(a["date"]),
    );

    return parentNotifs;
  }
}
