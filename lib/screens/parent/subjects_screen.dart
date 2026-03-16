import 'package:flutter/material.dart';
import '../../services/subjects_service.dart';

class SubjectsScreen extends StatefulWidget {
  final String className;
  final String semester;

  const SubjectsScreen(
      {Key? key, required this.className, required this.semester})
      : super(key: key);

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  final SubjectsService _service = SubjectsService();

  List<String> subjects = [];
  bool isLoading = true;

  static const Color green = Color(0xFF009846);

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final data = await _service.getSubjects(widget.className, widget.semester);

    setState(() {
      subjects = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0,
        title: Text(
          "Subjects - ${widget.className}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : subjects.isEmpty
              ? const Center(
                  child: Text(
                    "No subjects found",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: subjects.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          leading: CircleAvatar(
                            backgroundColor: green.withOpacity(0.15),
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                  color: green, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                            subjects[index],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
