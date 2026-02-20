import '../mock/mock_academics.dart';
import 'app_settings_service.dart';

class AttendanceService {
  final AppSettingsService _settingsService = AppSettingsService();

  Future<String> _getActiveSemester() async {
    return await _settingsService.getActiveSemester();
  }

  List<String> getDepartments() {
    return mockAcademics.keys.toList();
  }

  Future<List<String>> getClasses(String department) async {
    final activeSemester = await _getActiveSemester();

    final years = mockAcademics[department] ?? {};
    List<String> result = [];

    years.forEach((year, sems) {
      sems.forEach((semName, classList) {
        final semNumber = int.parse(semName.replaceAll(RegExp(r'[^0-9]'), ''));

        if (activeSemester == "EVEN" && semNumber % 2 == 0) {
          result.addAll(classList);
        } else if (activeSemester == "ODD" && semNumber % 2 != 0) {
          result.addAll(classList);
        }
      });
    });

    return result;
  }

  Future<List<String>> getMonths() async {
    final activeSemester = await _getActiveSemester();
    return activeSemester == "EVEN" ? evenMonths : oddMonths;
  }

  Future<bool> isMonthEnabled(String month) async {
    final activeSemester = await _getActiveSemester();
    final allowed = activeSemester == "EVEN" ? evenMonths : oddMonths;

    final current = getCurrentMonth();

    if (!allowed.contains(month)) return false;
    if (!allowed.contains(current)) return true;

    return allowed.indexOf(month) < allowed.indexOf(current);
  }
}
