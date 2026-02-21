import '../models/user_auth_model.dart';

List<UserAuth> mockUsers = [
  UserAuth(
    user_id: 99,
    name: "System Admin",
    email: "admin@test.com",
    role: "admin",
    status: "approved",
  ),
  UserAuth(
    user_id: 2,
    name: "Sunil Dodake",
    email: "sunil@test.com",
    role: "teacher",
    status: "approved",
    departments: ["IF", "CO"], // multiple dept
  ),
  UserAuth(
    user_id: 4,
    name: "Samidha",
    email: "samidha@test.com",
    role: "teacher",
    status: "approved",
    departments: ["IF"], // single dept
  ),
  UserAuth(
    user_id: 3,
    name: "mr sharma",
    email: "parent@test.com",
    role: "parent",
    status: "pending",
  ),
  UserAuth(
    user_id: 1,
    name: "emma",
    email: "student@test.com",
    role: "student",
    status: "approved",
  ),
  UserAuth(
    user_id: 10,
    name: "Yogita Khandagale",
    email: "hod_it@test.com",
    role: "hod",
    status: "approved",
    departments: ["IF"],
  ),
  UserAuth(
    user_id: 11,
    name: "Vijay Patil",
    email: "hod_co@test.com",
    role: "hod",
    status: "approved",
    departments: ["CO"],
  ),
  UserAuth(
    user_id: 12,
    name: "Anjum Mujawar",
    email: "hod_ej@test.com",
    role: "hod",
    status: "approved",
    departments: ["EJ"],
  ),
  UserAuth(
    user_id: 30,
    name: "Ashish Ukidve",
    email: "principal@test.com",
    role: "principal",
    status: "approved",
    departments: ["IF", "CO", "EJ"], // 🔥 important
  ),
];
