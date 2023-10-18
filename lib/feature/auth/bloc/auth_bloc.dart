import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techincal_test_flutter/feature/auth/service/auth_service.dart';
import 'package:techincal_test_flutter/model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on(onProsesRegister);

    on(onProsesLogin);

    on(onProsesGetDataById);

    on(onProsesLogout);

    on(onProsesForgotPass);
  }

  Future onProsesRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await AuthService().registerWithEmail(
      nama: event.nama,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (error) => emit(AuthFailed(message: error)),
      (success) => emit(AuthLoaded(userModel: success)),
    );
  }

  Future onProsesLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await AuthService().loginWithEmail(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (error) => emit(AuthFailed(message: error)),
      (success) => emit(AuthLoaded(userModel: success)),
    );
  }

  Future onProsesGetDataById(
      GetDataByIdEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await AuthService().getDataCredentials(
      uid: event.uid,
    );

    result.fold(
      (error) => emit(AuthFailed(message: error)),
      (success) => emit(AuthLoaded(userModel: success)),
    );
  }

  Future onProsesLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await AuthService().logoutUser();

    result.fold(
      (error) => emit(AuthFailed(message: error)),
      (success) => emit(AuthDone()),
    );
  }

  Future onProsesForgotPass(
      ForgotPassEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await AuthService().forgotPass(event.email!);
    
    result.fold(
      (error) => emit(AuthFailed(message: error)),
      (success) => emit(AuthDone()),
    );
  }
}
