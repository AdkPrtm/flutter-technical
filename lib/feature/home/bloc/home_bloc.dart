import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techincal_test_flutter/feature/home/service/home_service.dart';
import 'package:techincal_test_flutter/model/user_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on(onGetDataProses);
  }

  Future onGetDataProses(GetDataUserEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await HomeService().getDataUser();

    result.fold(
      (error) => emit(HomeError(message: error)),
      (success) => emit(HomeLoaded(listUser: success)),
    );
  }
}
