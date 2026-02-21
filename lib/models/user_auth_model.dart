class UserAuth {
  final int user_id;
  final String name;
  final String email;
  final String role;
  final String status;
  final List<String> departments;

  UserAuth({
    required this.user_id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    List<String>? departments,
  }) : departments = departments ?? [];

  UserAuth copyWith({
    String? status,
    List<String>? departments,
  }) {
    return UserAuth(
      user_id: user_id,
      name: name,
      email: email,
      role: role,
      status: status ?? this.status,
      departments: departments ?? this.departments,
    );
  }

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      user_id: json['user_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      status: json['status'],
      departments: json['departments'] != null
          ? List<String>.from(json['departments'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": user_id,
      "name": name,
      "email": email,
      "role": role,
      "status": status,
      "departments": departments,
    };
  }
}
