class StudentSessionService {
  static Future<int> getCurrentStudentSemester() async {
    await Future.delayed(const Duration(milliseconds: 200));

    // 🔹 Temporary mock
    return 6;
  }
}
