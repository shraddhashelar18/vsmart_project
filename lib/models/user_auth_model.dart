class UserAuth {
  final int user_id;
  final String email;
  final String role;
  final String status;

  // 🔑 OPTIONAL (only for teacher)
  final List<String> departments;

  UserAuth({
    required this.user_id,
    required this.email,
    required this.role,
    required this.status,
    List<String>? departments,
  }) : departments = departments ?? [];
}
