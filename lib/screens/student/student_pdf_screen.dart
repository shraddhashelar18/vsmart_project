import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudentPDFScreen extends StatelessWidget {
  const StudentPDFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Download PDF"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.all(15),
          ),
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text("Download PDF Marksheet"),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("PDF downloaded (dummy).")),
            );
          },
        ),
      ),
    );
  }
}
