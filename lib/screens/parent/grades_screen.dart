import 'package:flutter/material.dart';
import '../../services/report_service.dart';

class GradesScreen extends StatefulWidget {
  final String enrollment;

  const GradesScreen({Key? key, required this.enrollment}) : super(key: key);

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  final ReportService _reportService = ReportService();

  Map<String, dynamic>? report;
  bool isLoading = true;

  static const Color green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final data = _reportService.getReportByEnrollment(widget.enrollment);

    setState(() {
      report = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final ct1 = Map<String, int>.from(report?["ct1Marks"] ?? {});
    final ct2 = Map<String, int>.from(report?["ct2Marks"] ?? {});

    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text(
          "Grades",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTestCard("Class Test 1 (CT1)", ct1),
          const SizedBox(height: 20),
          _buildTestCard("Class Test 2 (CT2)", ct2),
        ],
      ),
    );
  }

  Widget _buildTestCard(String title, Map<String, int> marks) {
    const int totalPerSubject = 30;

    int totalObtained = marks.values.fold(0, (a, b) => a + b);
    int totalMarks = marks.length * totalPerSubject;

    double percentage =
        totalMarks == 0 ? 0 : (totalObtained / totalMarks) * 100;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${percentage.toStringAsFixed(2)}%",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),

            /// Subject rows
            ...marks.entries.map((e) {
              double progress = e.value / totalPerSubject;

              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.key,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade300,
                      color: progress >= 0.6
                          ? Colors.green
                          : const Color(0xFFFF0000),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${e.value}/$totalPerSubject",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              );
            }),

            const Divider(),

            /// Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Marks",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("$totalObtained/$totalMarks",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
