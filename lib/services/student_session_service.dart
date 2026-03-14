import '../models/user_session.dart';

class StudentSessionService {
  static Future<int> getCurrentStudentSemester() async {
    return UserSession.currentUser!.semester ?? 1;
  }
}
