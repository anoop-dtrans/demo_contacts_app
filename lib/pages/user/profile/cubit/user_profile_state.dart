part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object?> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  const UserProfileLoaded({
    required this.user,
    this.imageFile,
  });

  /// User
  final User user;

  /// Image
  final XFile? imageFile;

  @override
  List<Object?> get props => [user, imageFile];
}

final class UserProfileError extends UserProfileState {
  final String errorMessage;

  const UserProfileError({required this.errorMessage});
}

final class UserProfileUpdated extends UserProfileState {
  /// User
  final User user;

  const UserProfileUpdated({required this.user});
}
