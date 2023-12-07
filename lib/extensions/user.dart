import 'package:demo_api_app/models/user.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

extension AuthUser on auth.User {
  /// Firebase Auth to App User
  User toAppUser() {
    return User(
      id: uid,
      email: email ?? '',
      name: displayName,
    );
  }
}
