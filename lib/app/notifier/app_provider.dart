import 'package:demo_api_app/managers/user/manager.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AppProvider extends ChangeNotifier {
  /// Current Logged in User, if user is not logged in,
  /// it will have an empty user
  User user = User.empty();

  /// Set User
  Future<void> onUserLogin(auth.User authUser) async {
    User appUser = User(
      id: authUser.uid,
      email: authUser.email ?? '',
      name: authUser.displayName,
    );
    await locator<UserManager>().create(appUser);
    user = appUser;
    notifyListeners();
  }

  /// On User Logout
  Future<void> onUserLogout() async {}
}
