import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class StudentNewService {

static const String base = "${ApiConfig.baseUrl}/admin/students";

Map<String, String> get headers => {
"Content-Type": "application/json",
"x-api-key": "VSMART_API_2026",
"Authorization": "Bearer ${SessionManager.token}",
};

/* ===============================
FETCH STUDENTS BY CLASS
=============================== */

Future<List<Map<String, dynamic>>> getStudentsByClass(String className) async {


final response = await http.post(
 Uri.parse("$base/get_students.php?token=${SessionManager.token}"),
  headers: headers,
  body: jsonEncode({
    "class": className
  }),
);

print("STUDENTS RESPONSE: ${response.body}");

if (response.statusCode != 200 || response.body.isEmpty) {
  return [];
}

final data = jsonDecode(response.body);

if (data["status"] == true) {
  return List<Map<String, dynamic>>.from(data["students"]);
}

return [];


}

/* ===============================
GET STUDENT DETAIL
=============================== */

Future<Map<String, dynamic>?> getStudentByEnrollment(String enrollment) async {

final response = await http.post(
Uri.parse("$base/get_student_detail.php?token=${SessionManager.token}"),
  headers: headers,
  body: jsonEncode({
    "enrollment": enrollment
  }),
);

print("STUDENT DETAIL RESPONSE: ${response.body}");

if (response.statusCode != 200 || response.body.isEmpty) {
  return null;
}

final data = jsonDecode(response.body);

if (data["status"] == true) {
  return data;
}

return null;


}

/* ===============================
ADD STUDENT
=============================== */

Future<bool> addStudent({
required String enrollment,
required String name,
required String email,
required String password,
required String phone,
required String parentPhone,
required String roll,
required String className,
}) async {

final response = await http.post(
 Uri.parse("$base/add_students.php?token=${SessionManager.token}"),
  headers: headers,
  body: jsonEncode({
    "enrollment": enrollment,
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
    "parentPhone": parentPhone,
    "roll": roll,
    "class": className
  }),
);

print("ADD STUDENT RESPONSE: ${response.body}");

if (response.statusCode != 200) {
  return false;
}

final data = jsonDecode(response.body);
return data["status"] ?? false;

}

/* ===============================
UPDATE STUDENT
=============================== */

Future<bool> updateStudent({
required int userId,
required String name,
required String phone,
required String parentPhone,
required String roll,
required String enrollment,
}) async {


final response = await http.post(
Uri.parse("$base/update_student.php?token=${SessionManager.token}"),
  headers: headers,
  body: jsonEncode({
    "user_id": userId,
    "name": name,
    "phone": phone,
    "parentPhone": parentPhone,
    "roll": roll,
    "enrollment": enrollment
  }),
);

print("UPDATE STUDENT RESPONSE: ${response.body}");

if (response.statusCode != 200) {
  return false;
}

final data = jsonDecode(response.body);
return data["status"] ?? false;

}

/* ===============================
DELETE STUDENT
=============================== */

Future<bool> deleteStudent(int userId) async {


final response = await http.post(
 Uri.parse("$base/delete_student.php?token=${SessionManager.token}"),
  headers: headers,
  body: jsonEncode({
    "user_id": userId
  }),
);

print("DELETE STUDENT RESPONSE: ${response.body}");

if (response.statusCode != 200) {
  return false;
}

final data = jsonDecode(response.body);
return data["status"] ?? false;


}

/* ===============================
STUDENTS BY PARENT PHONE
=============================== */

Future<List<Map<String, dynamic>>> getStudentsByParentPhone(String parentPhone) async {


final response = await http.post(
 Uri.parse("$base/get_students_by_parent.php?token=${SessionManager.token}"),
  headers: headers,
  body: jsonEncode({
    "parentPhone": parentPhone
  }),
);

if (response.statusCode != 200 || response.body.isEmpty) {
  return [];
}

final data = jsonDecode(response.body);

if (data["status"] == true) {
  return List<Map<String, dynamic>>.from(data["students"]);
}

return [];


}
}
