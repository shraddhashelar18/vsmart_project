import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/registration_request_model.dart';

class UserService {
  static const String base = "http://192.168.0.103:8080/vsmart_backend/api";

  /* ======================
        GET PENDING USERS
  ====================== */

  Future<List<RegistrationRequest>> getPendingRequests() async {
    final response = await http.get(
      Uri.parse("$base/admin/reports/get_pending_users.php"),
      headers: {
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer 09c6331c8cac7044deff06dabb090876043f3b1f1e6096c6b87cf8c38e289979"
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["status"] == true) {
        return (data["users"] as List).map((u) {
          return RegistrationRequest(
            requestId: int.parse(u["user_id"].toString()),
            fullName: u["fullName"] ?? "",
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

  Future<void> approveRequest(RegistrationRequest request) async {
     await http.post(
      Uri.parse("$base/admin/reports/approve_user.php"),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer 09c6331c8cac7044deff06dabb090876043f3b1f1e6096c6b87cf8c38e289979"
      },
      body: jsonEncode({"user_id": request.requestId}),
    );
  }



  /* ======================
        REJECT USER
  ====================== */

  Future<void> rejectRequest(RegistrationRequest request) async {
     await http.post(
      Uri.parse("$base/admin/reports/reject_user.php"),
      headers: {
        "Content-Type": "application/json",
        "x-api-key": "VSMART_API_2026",
        "Authorization": "Bearer 09c6331c8cac7044deff06dabb090876043f3b1f1e6096c6b87cf8c38e289979"
      },
      body: jsonEncode({"user_id": request.requestId}),
    );
  }
}
