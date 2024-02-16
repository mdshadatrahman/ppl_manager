part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadedState extends HomeState {}

final class HomeCreatingUserState extends HomeState {}

final class HomeUserCreatedState extends HomeState {
  HomeUserCreatedState({required this.message});
  final String message;
}

final class HomeUserUpdatingState extends HomeState {}

final class HomeUserUpdatedState extends HomeState {
  HomeUserUpdatedState({required this.message});
  final String message;
}

final class HomeErrorState extends HomeState {
  HomeErrorState({required this.error});
  final String error;
}

final class HomeLoadingState extends HomeState {}
