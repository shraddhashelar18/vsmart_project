import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';
import '../core/session_manager.dart';

class ClassesService {
  static const String base = "${ApiConfig.baseUrl}/hod";

  Future<List<String>> getPromotedClasses(String department) async {
    final response = await http.post(
      Uri.parse("$base/get_promoted_classes.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"department": department}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == false) {
      throw Exception(data["message"]);
    }

    return List<String>.from(data["classes"]);
  }

  Future<List<String>> getDetainedClasses(String department) async {
    final response = await http.post(
      Uri.parse("$base/get_detained_classes.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"department": department}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == false) {
      throw Exception(data["message"]);
    }

    return List<String>.from(data["classes"]);
  }
}
