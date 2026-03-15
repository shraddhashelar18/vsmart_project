import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/api_config.dart';
import '../core/session_manager.dart';
import '../models/user_session.dart';
import '../screens/student/models/result_model.dart';

class ResultsService {
  /* ================= FETCH RESULT ================= */

  static Future<ResultModel> getResultForDisplay(int semester) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/student/get_student_result.php"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SessionManager.token}"
      },
      body: jsonEncode({"student_id": UserSession.currentUser!.user_id}),
    );

    print("RESULT API STATUS: ${response.statusCode}");
    print("RESULT API BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["status"] != true) {
      throw Exception("Failed to load results");
    }

    return ResultModel(
      semester: int.tryParse(data["active_semester"].toString()) ?? 0,
      ct1Declared: data["ct1_published"] == "1",
      ct2Declared: data["ct2_published"] == "1",
      finalDeclared: data["final_published"] == "1",
      finalUploadAllowed: data["allow_marksheet_upload"].toString() == "1",
      finalPdfUploaded: false,
      reuploadAllowed: data["allow_reupload"] == "1",
      marks: Map<String, dynamic>.from(data["marks"] ?? {}),
      currentSemData: _buildCurrentGraph(data),
      allSemData: _buildAllSemGraph(data),
    );
  }

  /* ================= CURRENT SEM GRAPH ================= */

  static List<double> _buildCurrentGraph(Map data) {
    List<double> graph = [0, 0, 0];

    final list = data["current_sem_performance_graph"] ?? [];

    for (var item in list) {
      double percent = double.tryParse(item["percentage"].toString()) ?? 0;

      if (item["exam"] == "CT1") {
        graph[0] = percent;
      }

      if (item["exam"] == "CT2") {
        graph[1] = percent;
      }

      if (item["exam"] == "FINAL") {
        graph[2] = percent;
      }
    }

    return graph;
  }

  /* ================= ALL SEM GRAPH ================= */

  static List<double> _buildAllSemGraph(Map data) {
    final list = data["all_semester_graph"] ?? [];

    return list.map<double>((e) {
      return double.tryParse(e["percentage"].toString()) ?? 0;
    }).toList();
  }

  /* ================= UPLOAD MARKSHEET ================= */

  static Future<void> uploadMarksheet(String filePath) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("${ApiConfig.baseUrl}/student/upload_marksheet.php"),
    );

    request.headers.addAll({"Authorization": "Bearer ${SessionManager.token}"});

    request.files.add(
      await http.MultipartFile.fromPath(
        "marksheet",
        filePath,
      ),
    );

    var response = await request.send();

    var responseBody = await response.stream.bytesToString();

    print("UPLOAD RESPONSE: $responseBody");

    final data = jsonDecode(responseBody);

    if (data["status"] != true) {
      throw Exception(data["message"] ?? "Upload failed");
    }
  }
  
}
