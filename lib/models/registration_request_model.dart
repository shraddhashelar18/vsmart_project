class RegistrationRequest {
  final int requestId;
  final String fullName;
  final String email;
  final String role;
  final Map<String, dynamic> extraData;
  String status;

  RegistrationRequest({
    required this.requestId,
    required this.fullName,
    required this.email,
    required this.role,
    required this.extraData,
    this.status = "pending",
  });
}
