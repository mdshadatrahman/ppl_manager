part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeGetUserListEvent extends HomeEvent {}

final class HomeCreateUserEvent extends HomeEvent {
  HomeCreateUserEvent({required this.user});
  final User user;
}

final class HomeUpdateUserEvent extends HomeEvent {
  HomeUpdateUserEvent({required this.user});
  final User user;
}
