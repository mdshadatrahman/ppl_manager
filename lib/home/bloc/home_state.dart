part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadedState extends HomeState {}

final class HomeErrorState extends HomeState {
  HomeErrorState({required this.error});
  final String error;
}

final class HomeLoadingState extends HomeState {}
