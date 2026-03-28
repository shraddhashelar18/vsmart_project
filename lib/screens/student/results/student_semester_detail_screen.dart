import 'package:flutter/material.dart';
import '../../../models/user_session.dart';
import '../../../services/student_results_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class StudentSemesterDetailScreen extends StatefulWidget {
  final int semesterNumber;

  const StudentSemesterDetailScreen({
    super.key,
    required this.semesterNumber,
  });

  @override
  State<StudentSemesterDetailScreen> createState() =>
      _StudentSemesterDetailScreenState();
}

class _StudentSemesterDetailScreenState
    extends State<StudentSemesterDetailScreen> {
  final StudentResultsService _service = StudentResultsService();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Map<String, dynamic>? semesterData;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semester ${widget.semesterNumber}"),
        backgroundColor: const Color(0xFF009846),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : semesterData == null || semesterData!.isEmpty
              ? const Center(child: Text("No data available"))
              : _buildContent(),
    );
  }

  Widget _buildContent() {
   final int attendance =
        int.tryParse(semesterData?["attendance"].toString() ?? "0") ?? 0;

    final int percentage =
        double.tryParse(semesterData?["percentage"].toString() ?? "0")
                ?.round() ??
            0;
    final String status = semesterData?["status"] ?? "N/A";
    final Map<String, dynamic> marks =
    Map<String, dynamic>.from(semesterData?["marks"] ?? {});
       final trendRaw = semesterData?["attendanceTrend"];

    final Map<String, dynamic> trend =
        trendRaw is Map ? Map<String, dynamic>.from(trendRaw) : {};
        List<String> months;

    if (widget.semesterNumber % 2 == 1) {
      months = ["June", "July", "August", "September", "October", "November"];
    } else {
      months = ["December", "January", "February", "March", "April", "May"];
    }

    final values = months.map((m) => (trend[m] ?? 0).toDouble()).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF009846),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Semester ${widget.semesterNumber}",
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  "Overall: $percentage%",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  "Attendance: $attendance%",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  "Result: $status",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          

          const SizedBox(height: 24),

          const Text(
            "Attendance Trend",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                gridData: FlGridData(show: true, horizontalInterval: 20),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < months.length) {
                          return Text(
                            months[value.toInt()],
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 11),
                        );
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: const Color(0xFF009846),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF009846).withOpacity(0.4),
                          const Color(0xFF009846).withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    spots: values.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
const Text(
            "Exam Performance",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          ...marks.entries.map((subjectEntry) {
            final subject = subjectEntry.key;
            final exams = subjectEntry.value;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  ...exams.entries.map<Widget>((examEntry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(examEntry.key),
                          Text(
                            "${examEntry.value}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF009846),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 20),

          if (semesterData?["marksheetPdf"] != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF009846),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  _openPdf(semesterData!["marksheetPdf"]);
                },
                child: const Text(
                  "View Final Marksheet",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
    
  }

  Future<void> _loadData() async {
    try {
      final studentId = UserSession.currentUser!.user_id;

      final data = await _service.getSemesterDetails(
        studentId,
        widget.semesterNumber,
      );

      setState(() {
        semesterData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
  
  Future<void> _openPdf(String url) async {
    print("PDF URL RECEIVED: $url");
    try {
    final directory = await getApplicationDocumentsDirectory();
final file = File(
        '${directory.path}/Marksheet_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      // ✅ USE HTTP PACKAGE (NOT HttpClient)
      final response = await http.get(Uri.parse(url));

print("STATUS: ${response.statusCode}");
      print("HEADERS: ${response.headers}");
      print("BODY SAMPLE: ${response.body.substring(0, 100)}");
      if (response.statusCode != 200) {
        throw Exception("Failed to download PDF");
      }

     await file.writeAsBytes(response.bodyBytes, flush: true);

      if (await file.exists()) {
        await Future.delayed(const Duration(milliseconds: 300));
      await OpenFilex.open(
          file.path,
          type: "application/pdf",
        );
      } else {
        throw Exception("File not saved");
      }

      
    } catch (e) {
      print("PDF ERROR: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to open marksheet")),
      );
      
    }
  }
  
}
