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
        backgroundColor: green,
        title: const Text("Student Report"),
      ),
      body: student == null
          ? const Center(child: Text("No report found"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student['name'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  Text("Roll No: ${student['roll']}"),
                  const SizedBox(height: 12),
                  const Text("Exam Performance",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  ...student['marks']
                      .map<Widget>((e) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(e['exam']),
                            trailing: Text("${e['score']} / ${e['max']}"),
                          ))
                      .toList(),
                ],
              ),
            ),
    );
  }
}
