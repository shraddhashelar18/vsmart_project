import 'package:flutter/material.dart';

class UpdateThresholdScreen extends StatefulWidget {
  const UpdateThresholdScreen({super.key});

  @override
  State<UpdateThresholdScreen> createState() => _UpdateThresholdScreenState();
}

class _UpdateThresholdScreenState extends State<UpdateThresholdScreen> {
  final TextEditingController thresholdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Threshold")),
      
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: thresholdCtrl,
              decoration: const InputDecoration(
                labelText: "Enter New Threshold (%)",
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Threshold Updated to ${thresholdCtrl.text}%",
                    ),
                  ),
                );
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
