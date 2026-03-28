import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/registration_request_model.dart';
import '../core/api_config.dart';
import '../core/session_manager.dart';

class UserService {
  /* ======================
        GET PENDING USERS
  ====================== */

  Future<List<RegistrationRequest>> getPendingRequests() async {
    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/admin/reports/get_pending_users.php"),
      headers: {
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
        
      },
    );

    print("PENDING USERS RESPONSE: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["status"] == true) {
        return (data["users"] as List).map((u) {
          return RegistrationRequest(
            requestId: int.parse(u["user_id"].toString()),
            fullName: u["fullName"] ?? u["email"],
            email: u["email"] ?? "",
            role: u["role"] ?? "",
            extraData: {},
          );
        }).toList();
      }
    }

    return [];
  }

  /* ======================
        APPROVE USER
  ====================== */

  Future<void> approveRequest(
      RegistrationRequest request, String className) async {
    await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/reports/approve_user.php"),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({
        "user_id": request.requestId,
        "class": className // 🔥 ADD THIS
      }),
    );
  }
  /* ======================
        REJECT USER
  ====================== */

  Future<void> rejectRequest(RegistrationRequest request) async {
    await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/reports/reject_user.php"),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"user_id": request.requestId}),
    );
  }

  /* ======================
        GET USER DETAILS
  ====================== */

 Future<Map<String, dynamic>?> getUserDetails(int userId) async {
    final response = await http.get(
      Uri.parse(
          "${ApiConfig.baseUrl}/admin/reports/verify_registration.php?user_id=$userId"),
      headers: {
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      },
    );

    print("USER DETAIL STATUS: ${response.statusCode}");
    print("USER DETAIL BODY: ${response.body}");

    if (response.statusCode != 200 || response.body.isEmpty) {
      return null;
    }

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      // 🔥 HANDLE NULL DETAILS
      if (data["details"] != null) {
        return Map<String, dynamic>.from(data["details"]);
      }

      // 🔥 FALLBACK → USE USER DATA
      if (data["user"] != null) {
        return Map<String, dynamic>.from(data["user"]);
      }
    }

    return null;
  }
  Future<List<String>> getClassesByDepartment(String dept) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/admin/classes/get_classes_by_department.php"),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"department": dept}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
      return List<String>.from(data["classes"]);
    }

    return [];
  }
  Future<List<String>> getSubjectsByClass(String className) async {
    final response = await http.post(
      Uri.parse(
          "${ApiConfig.baseUrl}/admin/subject/get_subjects_by_class.php?token=${SessionManager.token}"),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"class_name": className}),
    );

    final data = jsonDecode(response.body);

    if (data["status"] == true) {
     return List<String>.from(data["subjects"].map((s) => s["name"]));
    }

    return [];
  }
}
