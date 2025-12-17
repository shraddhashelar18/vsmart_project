// lib/utils/chart_helper.dart

class ChartHelper {
  static List<Map<String, dynamic>> convertMarksForChart(
      Map<String, dynamic> rawMarks) {
    List<Map<String, dynamic>> chartData = [];

    rawMarks.forEach((subject, value) {
      chartData.add({
        "subject": subject,
        "ct1": value["ct1"] ?? 0,
        "ct2": value["ct2"] ?? 0,
        "semester": value["semester"] ?? 0,
      });
    });

    return chartData;
  }
}
