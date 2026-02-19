import 'package:flutter/material.dart';
import '../../models/registration_request_model.dart';
import '../../services/user_service.dart';
import 'verify_user_screen.dart';

class AdminUserApprovalScreen extends StatefulWidget {
  const AdminUserApprovalScreen({Key? key}) : super(key: key);

  @override
  State<AdminUserApprovalScreen> createState() =>
      _AdminUserApprovalScreenState();
}

class _AdminUserApprovalScreenState extends State<AdminUserApprovalScreen> {
  final UserService _service = UserService();
  late Future<List<RegistrationRequest>> _futureRequests;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  void _loadRequests() {
    _futureRequests = _service.getPendingRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Approvals"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: FutureBuilder<List<RegistrationRequest>>(
        future: _futureRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Pending Requests"));
          }

          final requests = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF009846),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(request.fullName),
                  subtitle: Text("Role: ${request.role.toUpperCase()}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyUserScreen(request: request),
                      ),
                    );

                    setState(() {
                      _loadRequests();
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
