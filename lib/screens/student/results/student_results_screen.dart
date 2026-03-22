import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../services/app_settings_service.dart';
import '../../../services/student_session_service.dart';
import 'download_academic_screen.dart';
import 'widgets/result_header.dart';
import 'widgets/current_class_box.dart';
import 'widgets/section_title.dart';
import 'widgets/ct_result_card.dart';
import 'widgets/final_exam_card.dart';
import '../models/result_model.dart';
import '../../../services/results_service.dart';

class StudentResultsScreen extends StatefulWidget {
  const StudentResultsScreen({super.key});

  @override
  State<StudentResultsScreen> createState() => _StudentResultsScreenState();
}

class _StudentResultsScreenState extends State<StudentResultsScreen> {
  ResultModel? result;
  bool loading = true;
int? activeSemester;
int? currentSemester;
  @override
  void initState() {
    super.initState();
    loadResult();
  }
Future<void> loadResult() async {
    currentSemester = await StudentSessionService.getCurrentStudentSemester();

    final data = await ResultsService.getResultForDisplay();

    setState(() {
      activeSemester = data.activeSemester;
      result = data;
      loading = false;
    });
  }
 @override
  Widget build(BuildContext context) {
    if (loading || result == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ⭐ IMPORTANT RULE
   // show no data only if backend sent nothing
   // Show No Data only if student is in same semester and CT1 not declared
  // Show No Data only if student is in Sem 1 and CT1 not declared
   if (!result!.ct1Declared &&
        !result!.ct2Declared &&
        !result!.finalDeclared) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No Data Available",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            const ResultHeader(),
            CurrentClassBox(className: result!.currentClass),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SectionTitle(
                title: "Current Semester Results",
               subtitle: "Semester ${result!.activeSemester}",
              ),
            ),
            if (result!.ct1Declared)
              CTResultCard(
                title: "Class Test 1 (CT1)",
                marks: result!.marks,
                examType: "CT1",
              ),

            if (result!.ct2Declared)
              CTResultCard(
                title: "Class Test 2 (CT2)",
                marks: result!.marks,
                examType: "CT2",
              ),
            FinalExamCard(
  declared: result!.finalDeclared,
  allowUpload: result!.finalUploadAllowed,
),
            const SizedBox(height: 20),

// -------- CURRENT SEM PERFORMANCE --------
           _performanceBarCard(result!.currentSemData),

            const SizedBox(height: 20),

// -------- ALL SEM OVERVIEW --------
            // -------- ALL SEM OVERVIEW --------
            _allSemGraphCard(result!.allSemData),

            const SizedBox(height: 20),

// -------- DOWNLOAD REPORT BUTTON --------
            if (result!.activeSemester > 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DownloadAcademicReportScreen(
                          activeSemester: result!.activeSemester,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    "Previous Semester Data",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009846),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

 Widget _performanceBarCard(List<double> data) {


  
    List<BarChartGroupData> bars = [];
    List<String> labels = [];

    if (data[0] > 0) {
      bars.add(_bar(0, data[0]));
      labels.add("CT1");
    }

    if (data[1] > 0) {
      bars.add(_bar(1, data[1]));
      labels.add("CT2");
    }

    if (data[2] > 0) {
      bars.add(_bar(2, data[2]));
      labels.add("Final");
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Current Semester Performance",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "Exam-wise percentage comparison",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                maxY: 100,
                alignment: BarChartAlignment.spaceEvenly,
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 25,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(labels[value.toInt()]),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                barGroups: bars,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _LegendDot(color: Colors.green, label: "Good (≥75%)"),
              _LegendDot(color: Colors.orange, label: "Average (60-74%)"),
              _LegendDot(color: Colors.red, label: "Low (<60%)"),
            ],
          ),
        ],
      ),
    );
  }
Widget _allSemGraphCard(List<double> data) {
    // ⭐ If no semester data
    if (data.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
            )
          ],
        ),
        child: const Center(
          child: Text(
            "No previous semester data available",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    // ⭐ Otherwise show graph
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "All Semesters Performance",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "Cumulative academic progress",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 25,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toInt().toString());
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
getTitlesWidget: (value, meta) {
                        int index = value.toInt();

                        if (index >= data.length) {
                          return const SizedBox();
                        }

                        return Text("Sem ${index + 1}");
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList(),
                    isCurved: true,
                    color: const Color(0xFF009846),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) {
    Color barColor;

    if (y >= 75) {
      barColor = Colors.green;
    } else if (y >= 60) {
      barColor = Colors.orange;
    } else {
      barColor = Colors.red;
    }

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 18,
          borderRadius: BorderRadius.circular(6),
          color: barColor,
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
