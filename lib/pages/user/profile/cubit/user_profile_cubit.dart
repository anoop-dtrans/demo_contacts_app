import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo_api_app/managers/user/manager.dart';
import 'package:demo_api_app/models/user.dart';
import 'package:demo_api_app/services/locator.dart';
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

  Future<String?> uploadImage() async {
    if (this.state is! UserProfileLoaded) return null;

    final state = this.state as UserProfileLoaded;

    try {
      final storageRef = FirebaseStorage.instance.ref();

      // Create a reference to "dp.jpg"
      final imagePath = "users/${state.user.id}/dp.jpg";
      final displayPictureRef = storageRef.child(imagePath);
      final file = File(state.imageFile!.path);
      await displayPictureRef.putFile(file);

      return imagePath;
    } on FirebaseException catch (e) {}
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    if (this.state is! UserProfileLoaded) return;

    final state = this.state as UserProfileLoaded;
    User updatedUser = state.user.copyWith();

    if (user.isNotEmpty) {
      updatedUser = state.user.copyWith(
        name: user['name'],
        email: user['email'],
        phone: user['phone'],
        company:
            user['company'] != null ? Company(name: user['company']) : null,
        website: user['website'],
      );
    }

    if (state.imageFile != null) {
      final imageUrl = await uploadImage();
      updatedUser = updatedUser.copyWith(imageUrl: imageUrl);
    }

    await _saveUser(updatedUser);
  }

  Future<void> _saveUser(User user) async {
    try {
      await locator<UserManager>().update(user);
      emit(UserProfileUpdated(user: user));
    } on FirebaseException catch (e) {}
  }
}
