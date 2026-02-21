import 'user_auth_model.dart';

class UserSession {
  static UserAuth? currentUser;

  static void setUser(UserAuth user) {
    currentUser = user;
  }

  static void clear() {
    currentUser = null;
  }
}
