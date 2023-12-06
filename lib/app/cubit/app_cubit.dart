import 'package:bloc/bloc.dart';
import 'package:demo_api_app/managers/user/manager.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(user: User.empty()));

  Future<void> initialize() async {
    auth.FirebaseAuth.instance.currentUser;
  }

  /// Set User
  Future<void> onUserLogin(auth.User user) async {
    final appUser = User(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName,
    );
    await locator<UserManager>().setUser(appUser);
    emit(state.copyWith(user: appUser));
  }

  /// On User Logout
  Future<void> onUserLogout() async {
    emit(state.copyWith(user: User.empty()));
  }
}
