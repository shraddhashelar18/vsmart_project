import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../mock/mock_registration_requests.dart';
import '../../models/registration_request_model.dart';

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

  final List<String> classList = [
    "IF1KA",
    "IF2KA",
    "IF3KA",
    "IF4KA",
    "IF5KA",
    "IF6KA",
    "CO1KA",
    "CO2KA",
    "CO3KA",
    "CO4KA",
    "CO5KA",
    "CO6KA",
    "EJ1KA",
    "EJ2KA",
    "EJ3KA",
    "EJ4KA",
    "EJ5KA",
    "EJ6KA",
  ];

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
                      .map((cls) =>
                          DropdownMenuItem(value: cls, child: Text(cls)))
                      .toList(),
                  onChanged: (value) => studentClass = value!,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> extraData = {};

                    if (selectedRole == "student") {
                      extraData = {
                        "Enrollment No": studentEnrollmentNo,
                        "Roll No": rollNo,
                        "Class": studentClass,
                        "Student Mobile": studentMobile,
                        "Parent Mobile": parentMobile,
                      };
                    } else if (selectedRole == "teacher") {
                      extraData = {
                        "Employee ID": employeeId,
                        "Mobile": teacherMobile,
                      };
                    } else if (selectedRole == "parent") {
                      extraData = {
                        "Enrollment No": enrollmentNo,
                        "Mobile": parentOwnMobile,
                      };
                    }

                    final newRequest = RegistrationRequest(
                      requestId: DateTime.now().millisecondsSinceEpoch,
                      fullName: fullName,
                      email: email,
                      role: selectedRole,
                      extraData: extraData,
                    );

                    mockRegistrationRequests.add(newRequest);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Registration request sent to admin"),
                      ),
                    );
                  }
                },

                child: const Text(
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
        decoration: _decoration(hint, icon),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "$hint is required";
          }

          // Full Name validation: no numbers
          if (hint == "Full Name" && RegExp(r'[0-9]').hasMatch(value)) {
            return "Name cannot contain numbers";
          }

          // Email validation: proper format
          if (hint == "Email Address") {
            final emailReg = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
            if (!emailReg.hasMatch(value)) {
              return "Enter valid email";
            }
          }

          return null;
        },
      ),
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
      children: const [
        CircleAvatar(
          radius: 32,
          backgroundColor: Color(0xFF009846),
          child: Icon(Icons.school, color: Colors.white, size: 28),
        ),
        SizedBox(height: 10),
        Text(
          "Vsmart",
          style: TextStyle(
            color: Color(0xFF009846),
            fontSize: 22,
            fontWeight: FontWeight.w600,
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
