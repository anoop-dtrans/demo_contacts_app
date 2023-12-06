import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:demo_api_app/managers/user/manager.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  Future<void> initialize() async {
    final user = locator<UserManager>().currentUser;
    emit(UserProfileLoaded(user: user));
  }

  Future<void> setImage(XFile file) async {
    /// Check for the size of the image, if size is more throw an error
    final user = locator<UserManager>().currentUser;
    emit(UserProfileLoaded(user: user, imageFile: file));
  }

  Future<void> uploadImage() async {}
}
