import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/user/service.dart';

class UserHttpService extends UserService {
  @override
  Future<User?> getUser(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUsers({UserFilter? filter}) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<void> create(User user) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> update(User user) {
    // TODO: implement update
    throw UnimplementedError();
  }

  // Future<Response> _getData(String path) async {
  //   final url = '';
  // }
}
