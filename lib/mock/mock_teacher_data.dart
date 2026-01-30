// STUDENTS LIST
final Map<String, List<Map<String, dynamic>>> mockStudents = {
  "IF6K-A": [
    {"id": "1", "roll": "001", "name": "Aarav Sharma"},
    {"id": "2", "roll": "002", "name": "Ananya Patel"},
    {"id": "3", "roll": "003", "name": "Arjun Kumar"},
  ]
};

// REPORT DATA (subject wise + CT-1/CT-2 publish)
final Map<String, Map<String, dynamic>> mockStudentReports = {
  // structure gets filled when teacher publishes
  // "1": { "name": "...", "roll": "...", "marks": { "CT-1": { score, max }, "CT-2": {...} } }
};
