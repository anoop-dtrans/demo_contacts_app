part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({required this.user});

  final User user;

  @override
  List<Object> get props => [];

  AppState copyWith({User? user}) {
    return AppState(user: user ?? this.user);
  }
}
