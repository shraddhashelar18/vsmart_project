import '../mock/mock_student_reports.dart';

class ReportService {
  Map<String, dynamic>? getReportByEnrollment(String enrollment) {
    return mockStudentReports[enrollment];
  }

  List<String> calculateWeakSubjects(String enrollment) {
    final report = mockStudentReports[enrollment];
    if (report == null) return [];

    final ct1 = report["ct1Marks"] ?? {};
    final ct2 = report["ct2Marks"] ?? {};

    List<String> weakSubjects = [];

    for (var subject in ct1.keys) {
      final ct1Mark = ct1[subject];
      final ct2Mark = ct2[subject];

      double finalValue;

      if (ct2Mark == null) {
        finalValue = ct1Mark.toDouble();
      } else {
        finalValue = (ct1Mark + ct2Mark) / 2;
      }

      if (finalValue < 15) {
        weakSubjects.add(subject);
      }
    }

    return weakSubjects;
  }
}
