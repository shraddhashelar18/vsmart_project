import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '../../services/teacher_report_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class PreviousSemestersScreen extends StatefulWidget {
  final String studentId;

  static const green = Color(0xFF009846);

  const PreviousSemestersScreen({Key? key, required this.studentId})
      : super(key: key);

  @override
  State<PreviousSemestersScreen> createState() =>
      _PreviousSemestersScreenState();
}

class _PreviousSemestersScreenState extends State<PreviousSemestersScreen> {
  String? selectedSemester;
  final TeacherReportService _service = TeacherReportService();
  Map<String, dynamic>? studentData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  List<String> semesterMonths = [];

  Future<void> _loadData() async {
    studentData = await _service.getPreviousSemesters(widget.studentId);

    if (studentData != null && studentData!.isNotEmpty) {
      selectedSemester = studentData!.keys.first;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (studentData == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PreviousSemestersScreen.green,
          title: const Text("Previous Semesters"),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (studentData!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PreviousSemestersScreen.green,
          title: const Text("Previous Semesters"),
        ),
        body: const Center(
          child: Text("No previous semester data found"),
        ),
      );
    }

    final semesterData =
        selectedSemester != null ? studentData![selectedSemester] : null;

    if (semesterData == null) {
      return const Scaffold(
        body: Center(child: Text("No semester selected")),
      );
    }

    final Map<String, dynamic> trend =
        Map<String, dynamic>.from(semesterData["attendanceTrend"]);

    List<String> months = trend.keys.toList();
    int semNumber =
        int.parse(selectedSemester!.replaceAll(RegExp(r'[^0-9]'), ''));

    Map<String, int> monthOrder;

    if (semNumber % 2 == 1) {
      // odd semesters: Jun–Nov
      monthOrder = {
        "June": 1,
        "July": 2,
        "August": 3,
        "September": 4,
        "October": 5,
        "November": 6,
      };
    } else {
      // even semesters: Dec–May
      monthOrder = {
        "December": 1,
        "January": 2,
        "February": 3,
        "March": 4,
        "April": 5,
        "May": 6,
      };
    }

    const shortMonth = {
      "January": "Jan",
      "February": "Feb",
      "March": "Mar",
      "April": "Apr",
      "May": "May",
      "June": "Jun",
      "July": "Jul",
      "August": "Aug",
      "September": "Sep",
      "October": "Oct",
      "November": "Nov",
      "December": "Dec",
    };

    months.sort((a, b) => (monthOrder[a] ?? 0).compareTo(monthOrder[b] ?? 0));

    final values = months.map((m) => (trend[m] ?? 0).toDouble()).toList();

    Map<String, dynamic> marks = {};

    if (semesterData["marks"] is Map) {
      marks = Map<String, dynamic>.from(semesterData["marks"]);
    }

    final double attendance = (semesterData["attendance"] ?? 0).toDouble();
    final double percentage = (semesterData["percentage"] ?? 0).toDouble();
    final String status = semesterData["status"];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: PreviousSemestersScreen.green,
        title: const Text("Previous Semesters"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Semester Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSemester,
                    isExpanded: true,
                    items: studentData!.keys
                        .map((sem) => DropdownMenuItem(
                              value: sem,
                              child: Text(sem),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSemester = value;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Summary Card

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: PreviousSemestersScreen.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedSemester ?? "",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13),
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
                      style: const TextStyle(color: Colors.white, fontSize: 15),
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

              const Text(
                "Attendance Trend",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: months.length - 1,
                    minY: 0,
                    maxY: 100,
                    clipData: FlClipData.none(),
                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: 20,
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 32,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= 0 &&
                                value.toInt() < months.length) {
                              return Text(
                                shortMonth[months[value.toInt()]] ?? "",
                                style: const TextStyle(fontSize: 11),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          interval: 20,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 12),
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
                        color: PreviousSemestersScreen.green,
                        barWidth: 3,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              PreviousSemestersScreen.green.withOpacity(0.4),
                              PreviousSemestersScreen.green.withOpacity(0.05),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        spots: values.asMap().entries.map((e) {
                          return FlSpot(
                            e.key.toDouble(),
                            e.value,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Exam Performance",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),

              ...marks.entries.map<Widget>((subjectEntry) {
                final subject = subjectEntry.key;
                final exams = subjectEntry.value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
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
                                  color: PreviousSemestersScreen.green,
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

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PreviousSemestersScreen.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (semesterData["marksheetPdf"] == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Marksheet not uploaded yet"),
                        ),
                      );
                      return;
                    }

                    _openPdf(semesterData["marksheetPdf"]);
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
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openPdf(String url) async {
    final response = await http.get(Uri.parse(url));

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/marksheet.pdf');

    await file.writeAsBytes(response.bodyBytes);

    await OpenFilex.open(file.path);
  }
}
