import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:demo_api_app/services/user/service.dart';

class UserManager {
  Future<void> create(User user) async {
    final service = locator<UserService>();
    final appUser = await service.getUser(user.id);
    if (appUser == null) {
      ///throw Exception('A user already exists!!!');
      await service.create(user);
    }
  }

  Future<void> update(User user) async {}
}
