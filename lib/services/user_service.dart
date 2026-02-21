import '../models/registration_request_model.dart';
import '../mock/mock_registration_requests.dart';
import '../models/user_auth_model.dart';
import '../mock/mock_users.dart';

class UserService {
  Future<List<RegistrationRequest>> getPendingRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return mockRegistrationRequests
        .where((r) => r.status == "pending")
        .toList();
  }

  Future<void> approveRequest(RegistrationRequest request) async {
    request.status = "approved";

    mockUsers.add(
      UserAuth(
        user_id: request.requestId,
        name: request.fullName,
        email: request.email,
        role: request.role,
        status: "approved",
      ),
    );

    mockRegistrationRequests.remove(request);
  }

  Future<void> rejectRequest(RegistrationRequest request) async {
    request.status = "rejected";
    mockRegistrationRequests.remove(request);
  }
}
