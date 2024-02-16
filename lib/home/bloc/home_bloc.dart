// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:people_manager/home/services/home_api_services.dart';
import 'package:people_manager/models/user.dart';

part 'home_event.dart';
part 'home_state.dart';

enum ActiveStatus { active, inactive }

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetUserListEvent>(_onHomeGetUserListEvent);
  }

  List<User> users = [];
  List<User> activeUsers = [];
  List<User> inactiveUsers = [];

  FutureOr<void> _onHomeGetUserListEvent(
    HomeGetUserListEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await HomeApiServices.getUsers().then((value) {
      value.fold(
        (users) {
          this.users = users;
          activeUsers = users
              .where(
                (user) => user.status == ActiveStatus.active.name,
              )
              .toList();
          inactiveUsers = users
              .where(
                (user) => user.status == ActiveStatus.inactive.name,
              )
              .toList();
          emit(HomeLoadedState());
        },
        (error) {
          emit(HomeErrorState(error: error));
        },
      );
    });
  }
}
