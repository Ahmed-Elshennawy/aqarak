part of 'my_profile_cubit.dart';

sealed class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

class MyProfileInitial extends MyProfileState {}

class MyProfileLoading extends MyProfileState {}

class MyProfileLoaded extends MyProfileState {
  final UserProfile userProfile;
  const MyProfileLoaded(this.userProfile);
}

class MyProfileError extends MyProfileState {
  final String message;
  const MyProfileError(this.message);
}
