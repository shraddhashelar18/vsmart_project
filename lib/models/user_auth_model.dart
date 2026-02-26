class UserAuth {
  final int user_id;
  final String name;
  final String email;
  final String role;
  final String status;
  final List<String> departments;

  // ✅ ADD THESE
  final String? className;
  final int? semester;

  UserAuth({
    required this.user_id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    List<String>? departments,
    this.className,
    this.semester,
  }) : departments = departments ?? [];

  UserAuth copyWith({
    String? status,
    List<String>? departments,
    String? className,
    int? semester,
  }) {
    return UserAuth(
      user_id: user_id,
      name: name,
      email: email,
      role: role,
      status: status ?? this.status,
      departments: departments ?? this.departments,
      className: className ?? this.className,
      semester: semester ?? this.semester,
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
      className: json['className'],
      semester: json['semester'],
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
      "className": className,
      "semester": semester,
    };
  }
}
