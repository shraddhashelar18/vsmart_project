import '../mock/mock_teacher_data.dart';
import '../mock/mock_teacher_classes.dart';
import '../mock/mock_teacher_departments.dart';
import '../mock/mock_teacher_subjects.dart';

class TeacherNewService{
  // ===============================
  // GET ALL TEACHERS
  // ===============================
  Future<List<Map<String, dynamic>>> getAllTeachers() async {
    return mockTeachers.entries.map((entry) {
      final id = entry.key;
      final data = entry.value;

      return {
        "id": id,
        "name": data["name"],
        "email": data["email"],
        "phone": data["phone"],
        "departments": mockTeacherDepartments[id] ?? [],
        "classes": mockTeacherClasses[id] ?? [],
        "subjects": mockTeacherSubjects[id] ?? {},
      };
    }).toList();
  }

  // ===============================
  // GET SINGLE TEACHER
  // ===============================
  Future<Map<String, dynamic>?> getTeacherById(int id) async {
    if (!mockTeachers.containsKey(id)) return null;

    return {
      "id": id,
      "name": mockTeachers[id]!["name"],
      "email": mockTeachers[id]!["email"],
      "phone": mockTeachers[id]!["phone"],
      "departments": mockTeacherDepartments[id] ?? [],
      "classes": mockTeacherClasses[id] ?? [],
      "subjects": mockTeacherSubjects[id] ?? {},
    };
  }

  List<String> getTeacherNamesByDepartment(String dept) {
    return mockTeacherDepartments.entries
        .where((e) => e.value.contains(dept))
        .map((e) {
          final teacherId = e.key;
          return mockTeachers[teacherId]?["name"] ?? "";
        })
        .where((name) => name.isNotEmpty)
        .toList();
  }

  // ===============================
  // ADD TEACHER
  // ===============================
  Future<void> addTeacher({
    required String name,
    required String email,
    required String phone,
    required List<String> departments,
    required List<String> classes,
  }) async {
    final newId = mockTeachers.isEmpty ? 1 : mockTeachers.keys.last + 1;

    mockTeachers[newId] = {
      "name": name,
      "email": email,
      "phone": phone,
    };

    mockTeacherDepartments[newId] = departments;
    mockTeacherClasses[newId] = classes;
    mockTeacherSubjects[newId] = {};
  }

  // ===============================
  // UPDATE TEACHER
  // ===============================
  Future<void> updateTeacher({
    required int id,
    required String name,
    required String phone,
    required List<String> departments,
    required List<String> classes,
  }) async {
    if (!mockTeachers.containsKey(id)) return;

    mockTeachers[id]!["name"] = name;
    mockTeachers[id]!["phone"] = phone;

    mockTeacherDepartments[id] = departments;
    mockTeacherClasses[id] = classes;
  }

  // ===============================
  // DELETE TEACHER
  // ===============================
  Future<void> deleteTeacher(int id) async {
    mockTeachers.remove(id);
    mockTeacherDepartments.remove(id);
    mockTeacherClasses.remove(id);
    mockTeacherSubjects.remove(id);
  }

  // ===============================
  // UPDATE SUBJECTS FOR CLASS
  // ===============================
  Future<void> updateTeacherSubjects({
    required int teacherId,
    required String className,
    required List<String> subjects,
  }) async {
    mockTeacherSubjects[teacherId] ??= {};
    mockTeacherSubjects[teacherId]![className] = subjects;
  }

  List<String> getTeacherClasses(int teacherId) {
    return mockTeacherClasses[teacherId] ?? [];
  }

  List<String> getSubjectsForClass(int teacherId, String className) {
    return mockTeacherSubjects[teacherId]?[className] ?? [];
  }

  // ===============================
// SAVE ALL SUBJECTS FOR TEACHER
// ===============================
  Future<void> saveTeacherSubjects({
    required int teacherId,
    required Map<String, List<String>> subjectsPerClass,
  }) async {
    mockTeacherSubjects[teacherId] = subjectsPerClass;
  }

  bool isSubjectAlreadyAssigned({
    required String className,
    required String subject,
    int? excludeTeacherId,
  }) {
    for (var entry in mockTeacherSubjects.entries) {
      final teacherId = entry.key;

      // Skip current teacher in edit mode
      if (excludeTeacherId != null && teacherId == excludeTeacherId) {
        continue;
      }

      final subjectsPerClass = entry.value;

      if (subjectsPerClass.containsKey(className)) {
        if (subjectsPerClass[className]!.contains(subject)) {
          return true;
        }
      }
    }

    return false;
  }
}
