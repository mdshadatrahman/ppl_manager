// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:people_manager/home/services/home_api_services.dart';
import 'package:people_manager/models/user.dart';
import 'package:people_manager/utils/app_strings.dart';

part 'home_event.dart';
part 'home_state.dart';

enum ActiveStatus { active, inactive }

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetUserListEvent>(_onHomeGetUserListEvent);
    on<HomeCreateUserEvent>(_onHomeCreateUserEvent);
    on<HomeUpdateUserEvent>(_onHomeUpdateUserEvent);
  }

  /// List of [User] fetched from the API for the first time.
  List<User> users = [];

  /// List of [User] with status [ActiveStatus.active].
  List<User> activeUsers = [];

  /// List of [User] with status [ActiveStatus.inactive].
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

  FutureOr<void> _onHomeCreateUserEvent(
    HomeCreateUserEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeCreatingUserState());
    await HomeApiServices.createUsers(event.user).then((value) {
      value.fold(
        (user) {
          if (user.status == ActiveStatus.active.name) {
            activeUsers.insert(0, user);
          } else {
            inactiveUsers.insert(0, user);
          }
          emit(HomeUserCreatedState(message: AppStrings.providerCreatedSuccessfully));
          emit(HomeLoadedState());
        },
        (error) {
          emit(HomeErrorState(error: error));
          emit(HomeLoadedState());
        },
      );
    });
  }

  FutureOr<void> _onHomeUpdateUserEvent(
    HomeUpdateUserEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeUserUpdatingState());
    await HomeApiServices.updateUsers(event.user).then((value) {
      value.fold(
        (updatedUser) {
          /// Remove the updated user from the list and add it to the top of the list.
          for (var i = 0; i < activeUsers.length; i++) {
            if (activeUsers[i].id == updatedUser.id) {
              activeUsers.removeAt(i);
              break;
            }
          }

          for (var i = 0; i < inactiveUsers.length; i++) {
            if (inactiveUsers[i].id == updatedUser.id) {
              inactiveUsers.removeAt(i);
              break;
            }
          }

          if (updatedUser.status == ActiveStatus.active.name) {
            activeUsers.insert(0, updatedUser);
          } else {
            inactiveUsers.insert(0, updatedUser);
          }

          emit(HomeUserUpdatedState(message: AppStrings.providerUpdatedSuccessfully));
          emit(HomeLoadedState());
        },
        (error) {
          emit(HomeErrorState(error: error));
          emit(HomeLoadedState());
        },
      );
    });
  }
}
