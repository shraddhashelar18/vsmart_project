class NotificationModel {
  final String title;
  final String message;
  final String date;

  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      message: json['message'],
      date: json['date'],
    );
  }
}
