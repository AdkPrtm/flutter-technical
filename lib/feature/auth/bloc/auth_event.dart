part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String nama, email, password;

  const RegisterEvent({
    required this.nama,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [nama, email, password];
}

class LoginEvent extends AuthEvent {
  final String email, password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class GetDataByIdEvent extends AuthEvent {
  final String uid;

  const GetDataByIdEvent({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
}

class ForgotPassword extends AuthEvent {
  final String email;

  const ForgotPassword({required this.email});
  @override
  List<Object> get props => [email];
}

class LogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class ForgotPassEvent extends AuthEvent {
  final String? email;

  const ForgotPassEvent({required this.email});
  @override
  List<Object> get props => [email!];
}
