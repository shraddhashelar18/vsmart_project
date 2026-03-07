import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../models/student.dart';
import '../core/session_manager.dart';

class StudentService {
  static const String base = "${ApiConfig.baseUrl}/hod";
  Future<List<Student>> getStudentsByClass(String className) async {
    final url = Uri.parse("$base/get_students_by_class.php");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"class": className}),
    );
    print("STUDENTS RESPONSE: ${response.body}");
    final data = jsonDecode(response.body);

    if (data["status"] == false) {
      throw Exception(data["message"]);
    }

    List<Student> students = [];

    for (var s in data["students"]) {
      students.add(
        Student(
          id: s["id"],
          name: s["name"],
          rollNo: s["rollNo"],
          enrollmentNo: s["enrollmentNo"],
          email: s["email"],
          phone: s["phone"],
          parentMobile: s["parentMobile"],
          backlogCount: s["backlogCount"],
          promotionStatus: s["promotionStatus"],
          ct1Marks: s["ct1Marks"] is Map
              ? Map<String, String>.from(s["ct1Marks"])
              : {},
          ct2Marks: s["ct2Marks"] is Map
              ? Map<String, String>.from(s["ct2Marks"])
              : {},
          finalResults: s["finalResults"] is Map
              ? Map<String, String>.from(s["finalResults"])
              : {},
          percentage: s["percentage"] != null
              ? double.tryParse(s["percentage"].toString())
              : null,
          ktSubjects:
              s["ktSubjects"] != null ? List<String>.from(s["ktSubjects"]) : [],
        ),
      );
    }

    return students;
  }

  Future<List<Student>> getPromotedStudents(String className) async {
    final url = Uri.parse("$base/get_promoted_students.php");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"class": className}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == false) {
      throw Exception(data["message"]);
    }

    List<Student> students = [];

    for (var s in data["students"]) {
      students.add(
        Student(
          id: "",
          name: s["name"] ?? "",
          rollNo: "",
          enrollmentNo: "",
          email: "",
          phone: "",
          parentMobile: "",
          backlogCount: s["backlogCount"] ?? 0,
          promotionStatus: s["promotionStatus"] ?? "",
          ct1Marks: {},
          ct2Marks: {},
          finalResults: {},
          percentage: s["percentage"] != null
              ? double.tryParse(s["percentage"].toString())
              : null,
          ktSubjects:
              s["ktSubjects"] != null ? List<String>.from(s["ktSubjects"]) : [],
          oldClass: s["oldClass"],
          newClass: s["newClass"],
        ),
      );
    }

    return students;
  }
}
