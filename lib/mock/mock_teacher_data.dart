// STUDENTS LIST
final Map<String, List<Map<String, dynamic>>> mockStudents = {
  "IF6K-A": [
    {"id": "1", "roll": "001", "name": "Aarav Sharma"},
    {"id": "2", "roll": "002", "name": "Ananya Patel"},
    {"id": "3", "roll": "003", "name": "Arjun Kumar"},
  ]
};

/*
STRUCTURE (IMPORTANT)

mockStudentReports = {
  studentId: {
    "name": String,
    "roll": String,
    "marks": {
      subject: {
        "CT-1": { "score": int, "max": int },
        "CT-2": { "score": int, "max": int }
      }
    }
  }
}
*/

final Map<String, Map<String, dynamic>> mockStudentReports = {};
