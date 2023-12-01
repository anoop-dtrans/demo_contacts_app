import 'package:demo_api_app/models/user.dart';

abstract class UserService {
  /// Get Users
  Future<List<User>> getUsers({UserFilter? filter});

  /// Get User by Id
  Future<User?> getUser(String userId);

  /// Create User
  Future<void> create(User user);

  /// Update User
  Future<void> update(User user);
}

abstract class UserFilter {}
