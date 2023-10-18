part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthDone extends AuthState {}

final class AuthLoaded extends AuthState {
  final UserModel? userModel;

  const AuthLoaded({this.userModel});

  @override
  List<Object> get props => [userModel!];
}

final class AuthFailed extends AuthState {
  final String? message;

  const AuthFailed({this.message});

  @override
  List<Object> get props => [message!];
}
