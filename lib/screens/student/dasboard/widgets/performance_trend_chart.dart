import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PerformanceTrendChart extends StatelessWidget {
  final List<double> values;
  const PerformanceTrendChart({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: SizedBox(
        height: 180,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: const Color(0xFF009846),
                spots: values
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
