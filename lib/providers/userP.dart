import '../helper/session_helper.dart';

class UserP {
  UserP(this.sessionHelper);

  final SessionHelper sessionHelper;

  Future<void> login({required String username, required String password}) {
    return sessionHelper.saveLogin(username: username, password: password);
  }

  Future<bool> isLogin() {
    return sessionHelper.isLogin();
  }

  Future<String> getUsername() {
    return sessionHelper.getUsername();
  }

  Future<void> logout() {
    return sessionHelper.logout();
  }
}
