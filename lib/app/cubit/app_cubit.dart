import 'package:bloc/bloc.dart';
import 'package:demo_api_app/extensions/user.dart';
import 'package:demo_api_app/managers/user/manager.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState(user: User.empty()));

  Future<void> initialize() async {
    final user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      final appUser = await locator<UserManager>().getUser(user.uid);
      emit(state.copyWith(user: appUser));
    }
  }

  /// Set User
  Future<void> onUserLogin(auth.User user) async {
    final appUser = user.toAppUser();
    await locator<UserManager>().setUser(appUser);
    emit(state.copyWith(user: appUser));
  }

  /// On User Logout
  Future<void> onUserLogout() async {
    emit(state.copyWith(user: User.empty()));
  }
}
