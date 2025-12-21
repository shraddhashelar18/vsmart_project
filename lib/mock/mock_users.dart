import '../models/user_auth_model.dart';

List<UserAuth> mockUsers = [
  UserAuth(
    user_id: 1,
    email: "student@test.com",
    role: "student",
    status: "pending",
  ),
  UserAuth(
    user_id: 2,
    email: "teacher@test.com",
    role: "teacher",
    status: "pending",
  ),
  UserAuth(
    user_id: 3,
    email: "parent@test.com",
    role: "parent",
    status: "approved",
  ),
];
