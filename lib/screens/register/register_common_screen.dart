import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/auth_service.dart';

class RegisterCommonScreen extends StatefulWidget {
  const RegisterCommonScreen({Key? key}) : super(key: key);

  @override
  State<RegisterCommonScreen> createState() => _RegisterCommonScreenState();
}

class _RegisterCommonScreenState extends State<RegisterCommonScreen> {
  final _formKey = GlobalKey<FormState>();

  // ---------- COMMON ----------
  String fullName = "";
  String email = "";
  String password = "";
  String selectedRole = "";
  bool isPasswordVisible = false;
  bool isLoading = false;

  // ---------- STUDENT ----------
  String rollNo = "";
  String studentClass = "";
  String studentMobile = "";
  String parentMobile = "";
  String studentEnrollmentNo = "";

  // ---------- TEACHER ----------
  String employeeId = "";
  String teacherMobile = "";

  // ---------- PARENT ----------
  String enrollmentNo = "";
  String parentOwnMobile = "";

  List<String> classList = [];

  @override
  void initState() {
    super.initState();
    fetchClasses();
  }

  void fetchClasses() async {
    print("FETCH CLASSES CALLED");

    try {
      final classes = await AuthService.getClasses();

      setState(() {
        classList = classes;
      });

      print("CLASSES: $classes");
    } catch (e) {
      print("Error loading classes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 60),
              _header(),
              const SizedBox(height: 30),

              // ---------- COMMON FIELDS ----------
              _requiredField(
                hint: "Full Name",
                icon: Icons.person,
                onChanged: (v) => fullName = v,
              ),

              _requiredField(
                hint: "Email Address",
                icon: Icons.email,
                onChanged: (v) => email = v,
              ),

              _passwordField(),

              DropdownButtonFormField<String>(
                decoration: _decoration("Select Role", Icons.group),
                validator: (value) =>
                    value == null ? "Please select role" : null,
                items: const [
                  DropdownMenuItem(value: "student", child: Text("Student")),
                  DropdownMenuItem(value: "teacher", child: Text("Teacher")),
                  DropdownMenuItem(value: "parent", child: Text("Parent")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),

              const SizedBox(height: 10),

              // ================= STUDENT =================
              if (selectedRole == "student") ...[
                _requiredField(
                  hint: "Enrollment No",
                  icon: Icons.confirmation_number,
                  onChanged: (v) => studentEnrollmentNo = v,
                ),
                _requiredField(
                  hint: "Roll No",
                  icon: Icons.badge,
                  onChanged: (v) => rollNo = v,
                ),
                DropdownButtonFormField<String>(
                  decoration: _decoration("Class", Icons.class_),
                  validator: (value) =>
                      value == null ? "Please select class" : null,
                  items: classList
                      .map((cls) => DropdownMenuItem(
                            value: cls,
                            child: Text(cls),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      studentClass = value!;
                    });
                  },
                  hint: classList.isEmpty
                      ? const Text("Loading classes...")
                      : const Text("Select Class"),
                ),
                const SizedBox(height: 12),
                phoneField("Mobile Number", (v) => studentMobile = v),
                phoneField("Parent Mobile Number", (v) => parentMobile = v),
              ],

              // ================= TEACHER =================
              if (selectedRole == "teacher") ...[
                _requiredField(
                  hint: "Employee ID",
                  icon: Icons.badge,
                  onChanged: (v) => employeeId = v,
                ),
                phoneField(
                  "Mobile Number",
                  (v) => teacherMobile = v,
                ),
              ],

              // ================= PARENT =================
              if (selectedRole == "parent") ...[
                _requiredField(
                  hint: "Enrollment No",
                  icon: Icons.confirmation_number,
                  onChanged: (v) => enrollmentNo = v,
                ),
                phoneField(
                  "Mobile Number",
                  (v) => parentOwnMobile = v,
                ),
              ],

              const SizedBox(height: 20),

              // ---------- REGISTER BUTTON ----------
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009846),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  if (selectedRole == "student" && studentClass.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select class")),
                    );
                    return;
                  }
                  setState(() {
                    isLoading = true;
                  });

                  Map<String, dynamic> body = {
                    "fullName": fullName,
                    "email": email,
                    "password": password,
                    "selectedRole": selectedRole,
                  };

                  if (selectedRole == "student") {
                    body.addAll({
                      "studentEnrollmentNo": studentEnrollmentNo,
                      "rollNo": rollNo,
                      "studentClass": studentClass,
                      "studentMobile": studentMobile,
                      "parentMobile": parentMobile
                    });
                  }

                  if (selectedRole == "teacher") {
                    body.addAll({
                      "employeeId": employeeId,
                      "teacherMobile": teacherMobile
                    });
                  }

                  if (selectedRole == "parent") {
                    body.addAll({
                      "enrollmentNo": enrollmentNo,
                      "parentOwnMobile": parentOwnMobile
                    });
                  }

                  final result = await AuthService.register(body);

                  setState(() {
                    isLoading = false;
                  });

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result["message"])));
                },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  "Back to Login",
                  style: TextStyle(color: Color(0xFF009846)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- HELPERS ----------

  Widget phoneField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        maxLength: 10,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        decoration: _decoration(label, Icons.phone).copyWith(counterText: ""),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.length != 10) {
            return "Enter valid 10-digit number";
          }
          return null;
        },
      ),
    );
  }

  Widget _requiredField({
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
          decoration: _decoration(hint, icon).copyWith(counterText: ""),
          maxLength: hint == "Enrollment No"
              ? 11
              : hint == "Roll No"
                  ? 10
                  : hint == "Employee ID"
                      ? 10
                      : null,
          inputFormatters: hint == "Enrollment No"
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ]
              : hint == "Roll No"
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ]
                  : hint == "Employee ID"
                      ? [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Za-z0-9]')),
                          LengthLimitingTextInputFormatter(10),
                        ]
                      : [],
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "$hint is required";
            }

            // Full Name validation
            if (hint == "Full Name" && RegExp(r'[0-9]').hasMatch(value)) {
              return "Name cannot contain numbers";
            }

            // Email validation
            if (hint == "Email Address") {
              final emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
              if (!emailReg.hasMatch(value)) {
                return "Enter valid email";
              }
            }

            // Enrollment validation (11 digits)
            if (hint == "Enrollment No") {
              if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                return "Enrollment must be 11 digits";
              }
            }

            // Roll number validation (10 alphanumeric)
            if (hint == "Roll No") {
              if (!RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(value)) {
                return "Roll No must be 10 characters";
              }
            }
            // Employee ID validation(10 alphanumeric)
            if (hint == "Employee ID") {
              if (!RegExp(r'^[A-Za-z0-9]{10}$').hasMatch(value)) {
                return "Employee ID must be 10 characters";
              }
            }

            return null;
          }),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        decoration: _decoration("Password", Icons.lock).copyWith(
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ),
        onChanged: (v) => password = v,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Password is required";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        Image.asset(
          "assets/icon1.png",
          height: 80,
        ),
        SizedBox(height: 3),
        Text(
          "VSmart",
          style: TextStyle(
            color: Color(0xFF009846),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "A Smart Academic Management Platform",
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }

  InputDecoration _decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
