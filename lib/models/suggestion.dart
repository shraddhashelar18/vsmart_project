class Suggestion {
  final String id;
  final String title;
  final String body;
  final bool read;

  Suggestion({
    required this.id,
    required this.title,
    required this.body,
    this.read = false,
  });
}
