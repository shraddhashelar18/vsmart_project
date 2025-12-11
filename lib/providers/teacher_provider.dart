import 'package:flutter/material.dart';
import '../models/attendance_day.dart';
import '../services/api_service.dart';

class AttendanceProvider extends ChangeNotifier {
  Map<String, AttendanceDay> attendance = {};

  void setAttendance(String studentId, String status) {
    attendance[studentId] = AttendanceDay(studentId: studentId, status: status);
    notifyListeners();
  }

  Future<void> submitAttendance(String classId) async {
    for (var entry in attendance.entries) {
      await ApiService.sendLowAttendance(
        studentId: entry.key, // ✅ corrected parameter name
        message: entry.value.status,
      );
    }
  }
}
