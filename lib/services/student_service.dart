import '../models/student.dart';

class StudentService {
  Future<List<Student>> getStudentsByClass(String className) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final students = [
      Student(
        id: "1",
        name: "Emma Johnson",
        rollNo: "12",
        enrollmentNo: "ENR2023001",
        email: "emma@$className.com",
        phone: "9876543210",
        parentMobile: "9123456780",
        ct1Marks: {
          "Mathematics": "18",
          "Physics": "Absent",
          "Programming": "20",
        },
        ct2Marks: {
          "Mathematics": "20",
          "Physics": "19",
          "Programming": "Absent",
        },

        finalResults: {
          "Mathematics": "PASS",
          "Physics": "PASS",
          "Programming": "PASS",
        },

        backlogCount: 0, // temporary
      ),
      Student(
        id: "2",
        name: "Liam Smith",
        rollNo: "15",
        enrollmentNo: "ENR2023002",
        email: "liam@$className.com",
        phone: "9876543211",
        parentMobile: "9234567890",
        ct1Marks: {
          "Mathematics": "12",
          "Physics": "10",
          "Programming": "9",
        },
        ct2Marks: {
          "Mathematics": "14",
          "Physics": "Absent",
          "Programming": "8",
        },
        backlogCount: 0,
        finalResults: {
          "Mathematics": "PASS",
          "Physics": "FAIL",
          "Programming": "PASS",
        },
      ),
      Student(
        id: "2",
        name: "Liya Smith",
        rollNo: "15",
        enrollmentNo: "ENR2023002",
        email: "liam@$className.com",
        phone: "9876543211",
        parentMobile: "9234567890",
        ct1Marks: {
          "Mathematics": "12",
          "Physics": "10",
          "Programming": "9",
        },
        ct2Marks: {
          "Mathematics": "14",
          "Physics": "Absent",
          "Programming": "8",
        },
        backlogCount: 0,
        finalResults: {
          "Mathematics": "FAIL",
          "Physics": "FAIL",
          "Programming": "FAIL",
        },
      ),
    ];

    // 🔹 Auto calculate backlog count
    for (var student in students) {
      student.backlogCount = _calculateBacklogs(student);
    }
    return students;
  }

  int _calculateBacklogs(Student student) {
    int backlogs = 0;

    student.finalResults.forEach((subject, result) {
      if (result == "FAIL" || result == "ABSENT") {
        backlogs++;
      }
    });

    return backlogs;
  }

  Future<List<Student>> getPromotedStudents(String className) async {
    final students = await getStudentsByClass(className);

    return students.where((s) => s.promotionStatus == "PROMOTED").toList();
  }

  Future<List<Student>> getDetainedStudents(String className) async {
    final students = await getStudentsByClass(className);

    return students.where((s) => s.promotionStatus == "DETAINED").toList();
  }
}
