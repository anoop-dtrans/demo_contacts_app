import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo_api_app/managers/user/manager.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
import 'package:demo_api_app/services/user/service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  Future<void> initialize() async {
    final user = locator<UserManager>().currentUser;
    emit(UserProfileLoaded(user: user));
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setImage(file);
    }
  }

  Future<void> setImage(XFile file) async {
    /// Check for the size of the image, if size is more throw an error
    final user = locator<UserManager>().currentUser;
    emit(UserProfileLoaded(user: user, imageFile: file));
  }

  Future<void> uploadImage() async {
    if (this.state is! UserProfileLoaded) return;

    final state = this.state as UserProfileLoaded;

    try {
      final storageRef = FirebaseStorage.instance.ref();

      // Create a reference to "dp.jpg"
      final imagePath = "users/${state.user.id}/dp.jpg";
      final displayPictureRef = storageRef.child(imagePath);
      final file = File(state.imageFile!.path);
      await displayPictureRef.putFile(file);

      /// Update user in firestore
      final updatedUser = state.user.copyWith(imageUrl: imagePath);
      await locator<UserService>().update(updatedUser);

      emit(UserProfileUpdated(user: updatedUser));
    } on FirebaseException catch (e) {}
  }
}
