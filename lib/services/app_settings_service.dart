import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsService {
  static const _semesterKey = "activeSemester";
  static const _registrationKey = "registrationOpen";
  static const _resultsKey = "resultsPublished";
  static const _attendanceKey = "attendanceLocked";

  // ================= GETTERS =================

  Future<String> getActiveSemester() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_semesterKey) ?? "EVEN";
  }

  Future<bool> getRegistrationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_registrationKey) ?? true;
  }

  Future<bool> getResultsStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_resultsKey) ?? false;
  }

  Future<bool> getAttendanceLockStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_attendanceKey) ?? false;
  }

  // ================= SETTERS =================

  Future<void> setActiveSemester(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_semesterKey, value);
  }

  Future<void> setRegistrationStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_registrationKey, value);
  }

  Future<void> setResultsStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_resultsKey, value);
  }

  Future<void> setAttendanceLockStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_attendanceKey, value);
  }
  int _atktLimit = 2; // default

  Future<int> getAtktLimit() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _atktLimit;
  }

  Future<void> setAtktLimit(int value) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _atktLimit = value;
  }
}
