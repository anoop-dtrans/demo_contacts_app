import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/user/service.dart';

class FirestoreUserService extends UserService {
  final users = FirebaseFirestore.instance.collection('users');

  @override
  Future<User?> getUser(String userId) async {
    final snapshot = await users.doc(userId).get();
    if (!snapshot.exists) {
      return null;
    }

    return User.fromJson(snapshot.data()!);
  }

  @override
  Future<List<User>> getUsers({UserFilter? filter}) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  // Create User
  @override
  Future<void> create(User user) async {
    await users.doc(user.id).set({
      ...user.toJson(),
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    }, SetOptions(merge: false));
  }

  @override
  Future<void> update(User user) async {}
}
