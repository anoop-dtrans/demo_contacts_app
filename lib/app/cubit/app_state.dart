part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({required this.user});

  final User user;

  @override
  List<Object> get props => [user];

  AppState copyWith({User? user}) => AppState(user: user ?? this.user);
}
