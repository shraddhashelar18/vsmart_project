import 'package:flutter/material.dart';
import '../../models/registration_request_model.dart';
import '../../services/user_service.dart';
import 'assign_teacher_screen.dart';

class VerifyUserScreen extends StatefulWidget {
  final RegistrationRequest request;

  const VerifyUserScreen({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  State<VerifyUserScreen> createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  final UserService _service = UserService();

  Map<String, dynamic> details = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future loadDetails() async {
    final data = await _service.getUserDetails(widget.request.requestId);

    setState(() {
      details = data;
      loading = false;
    });
  }

  Widget infoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.request;

    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Registration"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: Column(
        children: [
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
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: Color(0xFF009846),
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                request.fullName,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                request.role.toUpperCase(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Divider(),

                      infoTile("Email", request.email),

                      const SizedBox(height: 10),

                      /// Dynamic registration fields
                      ...details.entries.map(
                        (e) => infoTile(e.key, e.value.toString()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Bottom buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      await _service.rejectRequest(request);
                      Navigator.pop(context);
                    },
                    child: const Text("Reject"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009846),
                    ),
                    onPressed: () async {
                      if (request.role == "teacher") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AssignTeacherScreen(request: request),
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
          )
        ],
      ),
    );
  }
}
