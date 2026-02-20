final mockAcademics = {
  "IF": {
    "FY": {
      "SEM 1": ["IF1KA", "IF1KB", "IF1KC"],
      "SEM 2": ["IF2KA", "IF2KB", "IF2KC"],
    },
    "SY": {
      "SEM 3": ["IF3KA", "IF3KB", "IF3KC"],
      "SEM 4": ["IF4KA", "IF4KB", "IF4KC"],
    },
    "TY": {
      "SEM 5": ["IF5KA", "IF5KB", "IF5KC"],
      "SEM 6": ["IF6KA", "IF6KB", "IF6KC"],
    },
  },
  "CO": {
    "FY": {
      "SEM 1": ["CO1KA", "CO1KB", "CO1KC"],
      "SEM 2": ["CO2KA", "CO2KB", "CO2KC"],
    },
    "SY": {
      "SEM 3": ["CO3KA", "CO3KB", "CO3KC"],
      "SEM 4": ["CO4KA", "CO4KB", "CO4KC"],
    },
    "TY": {
      "SEM 5": ["CO5KA", "CO5KB", "CO5KC"],
      "SEM 6": ["CO6KA", "CO6KB", "CO6KC"],
    },
  },
  "EJ": {
    "FY": {
      "SEM 1": ["EJ1KA", "EJ1KB", "EJ1KC"],
      "SEM 2": ["EJ2KA", "EJ2KB", "EJ2KC"],
    },
    "SY": {
      "SEM 3": ["EJ3KA", "EJ3KB", "EJ3KC"],
      "SEM 4": ["EJ4KA", "EJ4KB", "EJ4KC"],
    },
    "TY": {
      "SEM 5": ["EJ5KA", "EJ5KB", "EJ5KC"],
      "SEM 6": ["EJ6KA", "EJ6KB", "EJ6KC"],
    },
  },
};
// ---------- MONTHS ----------
final evenMonths = ["December", "January", "February", "March", "April", "May"];

final oddMonths = [
  "June",
  "July",
  "August",
  "September",
  "October",
  "November"
];
String getCurrentMonth() {
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  return months[DateTime.now().month - 1];
}
