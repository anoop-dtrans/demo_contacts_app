import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/user/service.dart';

class FirestoreUserService extends UserService {
  final users = FirebaseFirestore.instance.collection('users');

  @override
  Future<User?> getUser(String userId) async {
    final snapshot = await users.doc(userId).get();
    return snapshot.exists ? User.fromJson(snapshot.data()!) : null;
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
  Future<User?> update(User user) async {
    final data = {
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'website': user.website,
      'company': user.company?.toJson(),
    };
    await users.doc(user.id).set({
      ...data,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    }, SetOptions(merge: true));

    return getUser(user.id);
  }
}
