import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _checkAuthStatus();
  }

  void completeIconAnimation() {
    emit(const SplashIconAnimated(isSplashIconAnemated: true));
  }

  void completeAppNameAnimation() {
    emit(const SplashAppNameAnimated(isAppNameAnimated: true));
  }

  void _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(const SplashComplete(isLoggedIn: true));
    } else {
      emit(const SplashComplete(isLoggedIn: false));
    }
  }
}
