// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aqarak/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:aqarak/domain/entities/user_profile_model.dart';
import 'package:aqarak/domain/usecases/fetch_user_profile.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchUserProfile fetchUserProfile;
  final GoRouter router;
  HomeCubit({required this.fetchUserProfile, required this.router})
    : super(HomeInitial());

  Future<void> loadUserProfile(String uid) async {
    if (uid.isEmpty) {
      emit(HomeFailure('User not authenticated'));
      return;
    }
    emit(HomeLoading());
    try {
      final result = await fetchUserProfile(uid);
      result.fold(
        (failure) => emit(HomeFailure(failure.toString())),
        (userProfile) => emit(HomeLoaded(userProfile)),
      );
    } catch (e) {
      emit(HomeFailure('Failed to load profile: $e. Retrying...'));
      // Retry logic (e.g., after 2 seconds)
      await Future.delayed(const Duration(seconds: 2));
      await loadUserProfile(uid); // Recursive retry (add limit if needed)
    }
  }

  Future<void> logout() async {
    emit(HomeLoading());
    try {
      await fetchUserProfile.call('');
      fetchUserProfile.repository.logout();
      router.go(AppRouter.signInPage);
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
