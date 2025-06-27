import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void completeIconAnimation() {
    emit(const SplashIconAnimated(isSplashIconAnemated: true));
  }

  void completeAppNameAnimation() {
    emit(const SplashAppNameAnimated(isAppNameAnimated: true));

    Future.delayed(const Duration(seconds: 3), () {
      emit(PlashComplete());
    });
  }
}
