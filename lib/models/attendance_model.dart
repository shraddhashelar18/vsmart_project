class AttendanceDay {
  final String studentId;
  String status; // "Present" | "Absent" | "Late"

  AttendanceDay({required this.studentId, required this.status});

  factory AttendanceDay.fromJson(String studentId, Map<String, dynamic> json) {
    return AttendanceDay(studentId: studentId, status: json['status']);
  }
}
