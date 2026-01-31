import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/semester_result.dart';

class FinalExamCard extends StatelessWidget {
  final SemesterResult semester;

  const FinalExamCard({
    super.key,
    required this.semester,
  });

  Future<void> _pickPdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final fileName = result.files.single.name;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("PDF selected: $fileName"),
        ),
      );

      // TODO:
      // 1. Upload to backend
      // 2. Save as sem_X.pdf
      // 3. Mark finalPdfUploaded = true
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Final Exam (MSBTE)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // -------- Result not declared yet --------
          if (!semester.finalDeclared)
            const Text(
              "Results not declared yet",
              style: TextStyle(color: Colors.grey),
            ),

          // -------- Upload allowed --------
          if (semester.finalDeclared && semester.finalUploadAllowed)
            ElevatedButton.icon(
              onPressed: () {
                // Restrict re-upload
                if (semester.finalPdfUploaded && !semester.reuploadAllowed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Re-upload not allowed by admin"),
                    ),
                  );
                  return;
                }
                _pickPdf(context);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(
                semester.finalPdfUploaded
                    ? "Re-upload Marksheet"
                    : "Upload Marksheet",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009846),
              ),
            ),

          // -------- Upload disabled --------
          if (semester.finalDeclared && !semester.finalUploadAllowed)
            const Text(
              "Upload disabled by admin",
              style: TextStyle(color: Colors.grey),
            ),

          // -------- Uploaded state --------
          if (semester.finalPdfUploaded)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Marksheet uploaded",
                style: TextStyle(
                  color: Color(0xFF009846),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
        ),
      ],
    );
  }
}
