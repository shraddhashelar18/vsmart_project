import 'package:flutter/material.dart';
import '../../mock/mock_teacher_data.dart';

class StudentReportDetails extends StatelessWidget {
  final String studentId;
  static const green = Color(0xFF009846);

  const StudentReportDetails({Key? key, required this.studentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final student = mockStudentReports[studentId];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: green, title: const Text("Student Report")),
      body: student == null
          ? const Center(
              child:
                  Text("No report found", style: TextStyle(color: Colors.grey)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: const BoxDecoration(
                            color: green, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Text(student['name'][0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 16),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(student['name'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text("Roll No: ${student['roll']}",
                                style: TextStyle(color: Colors.grey.shade600)),
                          ]),
                    ]),
                    const SizedBox(height: 28),

                    /// exam section
                    const Text("Exam Performance",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 14),

                    ...((student["marks"] as Map).entries.map(
                      (entry) {
                        final subject = entry.key.toString();
                        final exams =
                            entry.value as Map; // exams = CT-1, CT-2 map


                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(subject,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                              const SizedBox(height: 12),
                              ...["CT-1", "CT-2"].map((exam) {
                                final data = exams[exam];

                                if (data == null) return const SizedBox();

                                final int score =
                                    (data["score"] as num).toInt();
                                final int max = (data["max"] as num).toInt();


                                return Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.06),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3))
                                      ]),
                                  child: Row(children: [
                                    Expanded(
                                        child: Text(exam,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14))),
                                    Text("$score / $max",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: green)),
                                  ]),
                                );
                              }).toList(),
                              const SizedBox(height: 18),
                            ]);
                      },
                    ).toList())
                  ]),
            ),
    );
  }
}
