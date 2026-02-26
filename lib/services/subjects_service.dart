import '../mock/mock_subject_data.dart';

class SubjectsService {
  List<String> getSubjectsByClass(String fullClassName) {
    if (fullClassName.isEmpty) return [];

    // Remove division letter only if it exists
    // IF6KA → IF6K
    String baseClass = fullClassName.length > 4
        ? fullClassName.substring(0, fullClassName.length - 1)
        : fullClassName;

    return semesterSubjects[baseClass] ?? [];
  }
}
