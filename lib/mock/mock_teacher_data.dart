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
      {"exam": "CT 1", "score": 21, "max":30},
      {"exam": "CT 2", "score": 22, "max": 30},
      
    ]
  },
  "2": {
    "name": "Ananya Patel",
    "roll": "002",
    "marks": [
      {"exam": "Unit Test", "score": 20, "max": 30},
      {"exam": "Mid Term", "score": 24, "max": 30},
    
    ]
  },
};
