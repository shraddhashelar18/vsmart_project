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
  @override
  void initState() {
    super.initState();
    loadResult();
  }

  Future<void> loadResult() async {
    final settingsService = AppSettingsService();
    final currentStudentSemester =
        await StudentSessionService.getCurrentStudentSemester();

    final semesterNumber =
        await settingsService.getActiveSemesterNumber(currentStudentSemester);

    final data = await ResultsService.getResultForDisplay(semesterNumber);

    setState(() {
      activeSemester = semesterNumber;
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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            const ResultHeader(),
            const CurrentClassBox(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SectionTitle(
                title: "Current Semester Results",
                subtitle: "Semester ${result!.semester} • In Progress",
              ),
            ),
            if (result!.ct1Declared)
              const CTResultCard(
                title: "Class Test 1 (CT1)",
              
              ),
            if (result!.ct2Declared)
              const CTResultCard(
                title: "Class Test 2 (CT2)",
                
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DownloadAcademicReportScreen(
                        activeSemester: 6,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                label: const Text(
                  "Download Full Academic Report (PDF)",
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

                // GRID EXACT LIKE UI
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
                        const labels = ["CT1", "CT2", "Final"];
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

                barGroups: [
                  _bar(0, data[0]),
                  _bar(1, data[1]),
                  _bar(2, data[2]),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // LEGEND
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _LegendDot(color: Colors.green, label: "Good (75%)"),
              _LegendDot(color: Colors.orange, label: "Average (60-74%)"),
              _LegendDot(color: Colors.red, label: "Low (<60%)"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _allSemGraphCard(List<double> data) {
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
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value % 1 != 0) return const SizedBox();
                        return Text("Sem ${value.toInt() + 1}");
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      data.length,
                      (i) => FlSpot(i.toDouble(), data[i]),
                    ),
                    isCurved: true,
                    color: const Color(0xFF009846),
                    barWidth: 3,
                    dotData: FlDotData(show: false),

                    // GRADIENT FILL LIKE UI
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF009846).withOpacity(0.3),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
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
