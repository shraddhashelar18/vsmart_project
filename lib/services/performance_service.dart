import 'attendance_service.dart';

class PerformanceService {
  final AttendanceService _attendanceService = AttendanceService();

  Future<List<String>> getDepartments() async {
    return _attendanceService.getDepartments();
  }

  Future<List<String>> getClasses(String dept) async {
    return _attendanceService.getClasses(dept);
  }
}
