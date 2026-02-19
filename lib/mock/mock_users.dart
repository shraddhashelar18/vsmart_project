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
    status: "pending",
    departments: ["IF", "CO"], // multiple dept
  ),
  UserAuth(
    user_id: 4,
    email: "teacher_it@test.com",
    role: "teacher",
    status: "approved",
    departments: ["IF"], // single dept
  ),
  UserAuth(
    user_id: 3,
    email: "parent@test.com",
    role: "parent",
    status: "pending",
  ),
  UserAuth(
    user_id: 1,
    email: "student@test.com",
    role: "student",
    status: "pending",
  ),
  UserAuth(
    user_id: 10,
    email: "hod_it@test.com",
    role: "hod",
    status: "approved",
    departments: ["IF"],
  ),
  UserAuth(
    user_id: 11,
    email: "hod_co@test.com",
    role: "hod",
    status: "approved",
    departments: ["CO"],
  ),
  UserAuth(
    user_id: 12,
    email: "hod_ej@test.com",
    role: "hod",
    status: "approved",
    departments: ["EJ"],
  ),
  UserAuth(
    user_id: 30,
    email: "principal@test.com",
    role: "principal",
    status: "approved",
    departments: ["IF", "CO", "EJ"], // 🔥 important
  ),
];
