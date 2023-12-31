part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<UserModel> listUser;

  const HomeLoaded({required this.listUser});
  @override
  List<Object> get props => [listUser];
}

final class HomeError extends HomeState {
  final String? message;

  const HomeError({required this.message});
  @override
  List<Object> get props => [message!];
}
