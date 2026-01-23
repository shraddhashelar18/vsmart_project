// STUDENTS ALLOCATED TO TEACHER BY CLASS
final Map<String, List<Map<String, dynamic>>> mockStudents = {
  "IF6K-A": [
    {"id": "1", "roll": "001", "name": "Aarav Sharma"},
    {"id": "2", "roll": "002", "name": "Ananya Patel"},
    {"id": "3", "roll": "003", "name": "Arjun Kumar"},
  ]
};

// DETAILED REPORTS (KEY = STUDENT ID)
final Map<String, dynamic> mockStudentReports = {
  "1": {
    "name": "Aarav Sharma",
    "roll": "001",
    "marks": [
      {"exam": "Unit Test", "score": 21, "max": 25},
      {"exam": "Mid Term", "score": 42, "max": 50},
      {"exam": "Final Exam", "score": 90, "max": 100},
    ]
  },
  "2": {
    "name": "Ananya Patel",
    "roll": "002",
    "marks": [
      {"exam": "Unit Test", "score": 20, "max": 25},
      {"exam": "Mid Term", "score": 44, "max": 50},
      {"exam": "Final Exam", "score": 88, "max": 100},
    ]
  },
};
