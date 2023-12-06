import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:demo_api_app/services/user/service.dart';

class UserManager {
  /// Current User
  User get currentUser => _user;

  /// Internal User
  User _user = User.empty();

  Future<void> setUser(User user) async {
    /// If user is not present create user
    final appUser = await userService.getUser(user.id);
    if (appUser == null) {
      ///throw Exception('A user already exists!!!');
      await userService.create(user);
    }

    _user = user;
  }

  Future<void> update(User user) async {
    await userService.update(user);
  }

  UserService get userService => locator<UserService>();
}
