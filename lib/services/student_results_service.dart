import '../mock/mock_previous_sem_data.dart';
class StudentResultsService {
  // map user_id → enrollment
  final Map<int, String> userIdToEnrollment = {
    1: "22001",
    6: "22002",
  };

  Future<Map<String, dynamic>> getSemesterDetails(
      int studentId, int semester) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final enrollment = userIdToEnrollment[studentId];

    if (enrollment == null) return {};

    final semesterKey = "Sem $semester";

    if (mockPreviousSemReports.containsKey(enrollment) &&
        mockPreviousSemReports[enrollment]!.containsKey(semesterKey)) {
      return Map<String, dynamic>.from(
        mockPreviousSemReports[enrollment]![semesterKey],
      );
    }

    return {};
  }
}
