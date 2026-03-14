import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../services/results_service.dart';

class FinalExamCard extends StatelessWidget {
  final bool declared;
  final bool allowUpload;

  const FinalExamCard({
    super.key,
    required this.declared,
    required this.allowUpload,
  });

  Future<void> _uploadMarksheet(BuildContext context) async {
    try {
      // open file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return;

      File file = File(result.files.single.path!);

      // upload to backend
 await ResultsService.uploadMarksheet(file.path);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Marksheet uploaded successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(Icons.description, size: 42, color: Colors.grey),
          const SizedBox(height: 14),
          const Text(
            "Final Exam",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          
          ElevatedButton(
            onPressed: allowUpload ? () => _uploadMarksheet(context) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF009846),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Upload Marksheet",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
