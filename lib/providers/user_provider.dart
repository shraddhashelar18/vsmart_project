import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? uid;
  String? role;
  Map<String, dynamic>? userData;

  void setUser({
    required String newUid,
    required String newRole,
    required Map<String, dynamic> newUserData,
  }) {
    uid = newUid;
    role = newRole;
    userData = newUserData;
    notifyListeners();
  }

  void clearUser() {
    uid = null;
    role = null;
    userData = null;
    notifyListeners();
  }
}
