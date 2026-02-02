import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'widgets/result_header.dart';
import 'widgets/current_class_box.dart';
import 'widgets/section_title.dart';
import 'widgets/ct_result_card.dart';
import 'widgets/final_exam_card.dart';

class StudentResultsScreen extends StatelessWidget {
  const StudentResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 MOCK DATA — REPLACE FROM BACKEND LATER
    bool ct1Declared = true;
    bool ct2Declared = true;
    bool finalDeclared = false;
    bool adminAllowedUpload = false; // from backend later
    // TODO BACKEND:
// [teacherCT1, teacherCT2, finalPdfPercentage]
    List<double> currentSemData = [78, 85, 90]; // CT1, CT2, Final
    List<double> allSemData = [72, 75, 80, 83, 86, 89];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: ListView(
          children: [
            const ResultHeader(),
            const CurrentClassBox(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: SectionTitle(
                title: "Current Semester Results",
                subtitle: "Semester 6 • In Progress",
              ),
            ),
            if (ct1Declared)
              const CTResultCard(
                title: "Class Test 1 (CT1)",
                grade: "A",
              ),
            if (ct2Declared)
              const CTResultCard(
                title: "Class Test 2 (CT2)",
                grade: "A+",
              ),
            FinalExamCard(
              declared: finalDeclared,
              allowUpload: adminAllowedUpload,
            ),
            const SizedBox(height: 20),

// -------- CURRENT SEM PERFORMANCE --------
            _performanceBarCard(currentSemData),

            const SizedBox(height: 20),

// -------- ALL SEM OVERVIEW --------
            _allSemGraphCard(allSemData),

            const SizedBox(height: 20),

// -------- DOWNLOAD REPORT BUTTON --------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {},
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
                      interval: 25,
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
                    sideTitles: SideTitles(showTitles: true, interval: 25),
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
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 18,
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF009846),
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
