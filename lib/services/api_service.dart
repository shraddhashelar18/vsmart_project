import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://10.0.2.2:3000'; // Replace with your server URL

  // --------------------------
  // Get student dashboard
  // --------------------------
  static Future<Map<String, dynamic>> getStudentDashboard(
    String studentId,
  ) async {
    final url = Uri.parse('$baseUrl/studentDashboard/$studentId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load student dashboard');
    }
  }

  // --------------------------
  // Get class dashboard
  // --------------------------
  static Future<Map<String, dynamic>> getClassDashboard(String classId) async {
    final url = Uri.parse('$baseUrl/classDashboard/$classId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load class dashboard');
    }
  }

  // --------------------------
  // Send low attendance notification
  // --------------------------
  static Future<Map<String, dynamic>> sendLowAttendance({
    required String studentId,
    required String message,
  }) async {
    final url = Uri.parse('$baseUrl/sendLowAttendance');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'student_id': studentId, 'message': message}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send low attendance notification');
    }
  }
}
