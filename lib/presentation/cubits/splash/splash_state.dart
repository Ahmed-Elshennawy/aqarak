part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashIconAnimated extends SplashState {
  final bool isSplashIconAnemated;

  const SplashIconAnimated({this.isSplashIconAnemated = false});

  @override
  List<Object> get props => [isSplashIconAnemated];
}

final class SplashAppNameAnimated extends SplashState {
  final bool isAppNameAnimated;

  const SplashAppNameAnimated({this.isAppNameAnimated = false});

  @override
  List<Object> get props => [isAppNameAnimated];
}

final class SplashComplete extends SplashState {
  final bool isLoggedIn;

  const SplashComplete({required this.isLoggedIn});

  @override
  List<Object> get props => [isLoggedIn];
}
