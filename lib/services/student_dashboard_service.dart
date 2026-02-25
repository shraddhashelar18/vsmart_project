import '../mock/mock_student_dashboard.dart';
import '../screens/student/models/dashboard_model.dart';

class StudentDashboardService {
  Future<DashboardModel> getDashboard(String enrollment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockDashboard;
  }
}
