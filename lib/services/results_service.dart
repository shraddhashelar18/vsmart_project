import '../screens/student/models/result_model.dart';
import '../mock/mock_student_results.dart';

class ResultsService {
  static Future<List<ResultModel>> fetchResults() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return mockResults;
  }

  static Future<ResultModel> getResultForDisplay(int activeSemester) async {
    final results = await fetchResults();

    ResultModel? current;

    try {
      current = results.firstWhere(
        (r) => r.semester == activeSemester,
      );
    } catch (e) {
      current = null;
    }

    // 🔹 If active semester is 1 → no previous semester exists
    if (activeSemester == 1) {
      if (current != null) return current;
      throw Exception("Semester 1 result not found");
    }

    // 🔹 If CT1 declared → show active semester
    if (current != null && current.ct1Declared) {
      return current;
    }

    // 🔹 Otherwise show previous semester
    return results.firstWhere(
      (r) => r.semester == activeSemester - 1,
      orElse: () => current!,
    );
  }
}
