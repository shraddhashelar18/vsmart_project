import 'package:flutter/material.dart';

class SemesterSelector extends StatelessWidget {
  final List<int> semesters;
  final int selected;
  final ValueChanged<int> onChanged;

  const SemesterSelector({
    super.key,
    required this.semesters,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Semester",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 12),
        DropdownButton<int>(
          value: selected,
          items: semesters
              .map(
                (sem) => DropdownMenuItem(
                  value: sem,
                  child: Text("Semester $sem"),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}
