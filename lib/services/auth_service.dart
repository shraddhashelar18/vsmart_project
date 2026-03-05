import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String base = "http://192.168.0.103:8080/vsmart_backend/api";

  /* ======================
      REGISTER USER
  ====================== */

  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> data) async {

  print("REGISTER BODY: ${jsonEncode(data)}");

  final response = await http.post(
    Uri.parse("$base/auth/register.php"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(data),
  );

  print("STATUS: ${response.statusCode}");
  print("RESPONSE: ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {"status": false, "message": "Server error"};
  }
}

  /* ======================
        GET CLASSES
  ====================== */

  static Future<List<String>> getClasses() async {
    final response = await http.get(
      Uri.parse("$base/all_classes.php"),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["status"] == true) {
        return List<String>.from(data["classes"]);
      }

      return [];
    }

    return [];
  }
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse("$base/auth/login.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    print("LOGIN RESPONSE: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return {"status": false, "message": "Server error"};
  }
}
