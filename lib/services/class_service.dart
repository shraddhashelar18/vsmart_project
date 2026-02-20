import '../mock/mock_class_data.dart';

class ClassService {
  // 🔹 GET ALL CLASSES
  List<Map<String, String>> getAllClasses() {
    return mockClasses.entries.map((e) {
      return {
        "name": e.key,
        "department": e.value["department"] ?? "",
        "teacher": e.value["teacher"] ?? "",
      };
    }).toList();
  }

  // 🔹 GET CLASSES BY DEPARTMENT
  List<Map<String, String>> getClassesByDepartment(String department) {
    return mockClasses.entries
        .where((e) => e.value["department"] == department)
        .map((e) => {
              "name": e.key,
              "department": e.value["department"] ?? "",
              "teacher": e.value["teacher"] ?? "",
            })
        .toList();
  }

  // 🔹 GET SINGLE CLASS
  Map<String, String>? getClass(String className) {
    return mockClasses[className];
  }

  // 🔹 SAVE / UPDATE CLASS
  void saveClass({
    required String name,
    required String department,
    required String teacher,
  }) {
    mockClasses[name] = {
      "department": department,
      "teacher": teacher,
    };
  }

  // 🔹 DELETE CLASS
  void deleteClass(String className) {
    mockClasses.remove(className);
  }
}
