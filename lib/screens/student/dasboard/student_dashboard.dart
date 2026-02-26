import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/user_session.dart';
import '../../../services/student_dashboard_service.dart';

import '../models/dashboard_model.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
  
}

class _StudentDashboardState extends State<StudentDashboard> {
  // -------- MOCK DATA (REPLACE WITH BACKEND LATER) --------
  static const green = Color(0xFF009846);

final StudentDashboardService _service = StudentDashboardService();
@override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final data = await _service.getDashboard(
      UserSession.currentUser!.user_id.toString(),
    );
    setState(() {
      dashboard = data;

      studentName = data.studentName;
      studentId = data.rollNo;
      className = data.className;
      semester = data.semester;
      department = data.department;
      presentDays = data.presentDays;
      absentDays = data.absentDays;
      trend = data.performanceTrend;

      subjects = data.subjects
          .map((s) => {
                "name": s.name,
                "marks": s.percent,
               
              })
          .toList();

      loading = false;
    });
  }
DashboardModel? dashboard;
  bool loading = true;

// These will be filled after loading
  late String studentName;
  late String studentId;
  late String className;
  late int semester;
  late String department;
  late int presentDays;
  late int absentDays;
  late List<double> trend;
  late List<Map<String, dynamic>> subjects;
  @override
  Widget build(BuildContext context) {
    if (loading || dashboard == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final totalDays = presentDays + absentDays;
    final attendancePercent = presentDays / totalDays;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _miniCards(),
                    const SizedBox(height: 16),
                    _attendanceCard(attendancePercent, totalDays),
                    const SizedBox(height: 16),
                    _trendCard(),
                    const SizedBox(height: 16),
                    _subjectSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        color: green,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
             
              Text("Vsmart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(studentName,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                  Text(studentId,
                      style: const TextStyle(color: Colors.white70)),
                  Text("$className - Semester $semester",
                      style: const TextStyle(color: Colors.white70)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // ---------------- MINI CARDS ----------------
  Widget _miniCards() {
    return Row(
      children: [
        Expanded(child: _miniCard("Current Sem", "Semester $semester")),
        const SizedBox(width: 12),
        Expanded(child: _miniCard("Department", department)),
      ],
    );
  }

  Widget _miniCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }

  // ---------------- ATTENDANCE ----------------
  Widget _attendanceCard(double percent, int totalDays) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Attendance Overview",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const SizedBox(height: 16),
          CircularPercentIndicator(
            radius: 70,
            lineWidth: 12,
            percent: percent,
            center: Text("${(percent * 100).toStringAsFixed(0)}%",
                style: const TextStyle(color: Colors.white, fontSize: 24)),
            progressColor: Colors.white,
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _attendanceTile("Present", presentDays),
              _attendanceTile("Absent", absentDays),
            ],
          ),
          const SizedBox(height: 8),
          Text("Total Days: $totalDays",
              style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _attendanceTile(String title, int value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white70)),
        Text("$value days",
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  // ---------------- TREND ----------------
  Widget _trendCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Performance Trend",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,

                  gridData: FlGridData(show: true),

                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            "Jan",
                            "Feb",
                            "Mar",
                            "Apr",
                            "May",
                            "Jun"
                          ];
                          if (value.toInt() >= 0 &&
                              value.toInt() < months.length) {
                            return Text(months[value.toInt()]);
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32, // 🔥 important
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

                  borderData: FlBorderData(show: false),

                  // 🔥 THIS WAS MISSING
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: green,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            green.withOpacity(0.4),
                            green.withOpacity(0.05),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      spots: trend.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value);
                      }).toList(),
                    ),
                  ],
                ),
              )

          ),
        ],
      ),
    );
  }

  // ---------------- SUBJECTS ----------------
  Widget _subjectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Subject-wise Performance",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...subjects.map((s) => _subjectCard(s)).toList(),
      ],
    );
  }

  Widget _subjectCard(Map<String, dynamic> s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s["name"],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            
            ],
          ),
          const SizedBox(height: 6),
          Text("Marks Obtained ${s["marks"]}/100"),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: s["marks"] / 100,
            color: green,
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(height: 4),
          Align(
              alignment: Alignment.centerRight, child: Text("${s["marks"]}%")),
        ],
      ),
    );
  }
}
