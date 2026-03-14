import 'user_auth_model.dart';

class UserSession {
  static UserAuth? currentUser;
  static String? token;

  static void setUser(UserAuth user, String authToken) {
    currentUser = user;
    token = authToken;
  }

  static void clear() {
    currentUser = null;
    token = null;
  }
}
