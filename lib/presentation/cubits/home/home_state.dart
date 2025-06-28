part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final UserProfile userProfile;

  const HomeLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

final class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}
