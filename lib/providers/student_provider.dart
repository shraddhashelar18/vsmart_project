import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/api_service.dart';

class StudentsProvider extends ChangeNotifier {
  List<Student> students = [];

  Future<void> fetchStudents(List<String> studentIds) async {
    students.clear();
    for (var id in studentIds) {
      final data = await ApiService.getStudentDashboard(id);
      students.add(Student.fromJson(data, id));
    }
    notifyListeners();
  }
}
