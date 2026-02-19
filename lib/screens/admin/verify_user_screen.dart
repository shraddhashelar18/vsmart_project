import 'package:flutter/material.dart';
import '../../models/registration_request_model.dart';
import '../../services/user_service.dart';
import 'assign_teacher_screen.dart';

class VerifyUserScreen extends StatelessWidget {
  final RegistrationRequest request;
  final UserService _service = UserService();

  VerifyUserScreen({
    Key? key,
    required this.request,
  }) : super(key: key);

  Widget _infoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Registration"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 👤 Profile Header
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundColor: Color(0xFF009846),
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request.fullName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  request.role.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),

                        _infoTile("Email", request.email),

                        const SizedBox(height: 10),

                        // 🔹 Dynamic Role Fields
                        ...request.extraData.entries.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _infoTile(e.key, e.value.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 🔹 Bottom Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await _service.rejectRequest(request);
                        Navigator.pop(context);
                      },
                      child: const Text("Reject"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF009846),
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                     onPressed: () async {
                        if (request.role.toLowerCase() == "teacher")
 {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AssignTeacherScreen(
                                request: request,
                              ),
                            ),
                          );
                        } else {
                          await _service.approveRequest(request);
                          Navigator.pop(context);
                        }
                      },

                      child: const Text("Approve"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
