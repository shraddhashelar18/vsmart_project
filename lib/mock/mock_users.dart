import '../models/user_auth_model.dart';

List<UserAuth> mockUsers = [
  UserAuth(
    user_id: 99,
    email: "admin@test.com",
    role: "admin",
    status: "approved",
  ),
  UserAuth(
    user_id: 2,
    email: "teacher@test.com",
    role: "teacher",
    status: "approved",
    departments: ["IT", "CO"], // multiple dept
  ),
  UserAuth(
    user_id: 4,
    email: "teacher_it@test.com",
    role: "teacher",
    status: "approved",
    departments: ["IT"], // single dept
  ),
  UserAuth(
    user_id: 3,
    email: "parent@test.com",
    role: "parent",
    status: "approved",
  ),
  UserAuth(
    user_id: 1,
    email: "student@test.com",
    role: "student",
    status: "pending",
  ),
];
