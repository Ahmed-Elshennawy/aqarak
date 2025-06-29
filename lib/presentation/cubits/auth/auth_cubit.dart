// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aqarak/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aqarak/domain/usecases/reset_password.dart';
import 'package:aqarak/domain/usecases/sign_in.dart';
import 'package:aqarak/domain/usecases/sign_up.dart';
import 'package:aqarak/domain/usecases/verify_otp.dart';
import 'package:go_router/go_router.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  SignUp signUp;
  SignIn signIn;
  VerifyOTP verifyOTP;
  ResetPassword resetPassword;
  final GoRouter router;
  AuthCubit({
    required this.signUp,
    required this.signIn,
    required this.verifyOTP,
    required this.resetPassword,
    required this.router,
  }) : super(AuthInitial());

  void performSignUp(
    String email,
    String password,
    String fullName,
    String mobileNumber,
  ) async {
    emit(AuthLoading());
    final result = await signUp(email, password, fullName, mobileNumber);
    result.fold((failure) => emit(AuthFailure(failure.toString())), (
      user,
    ) async {
      await FirebaseFirestore.instance.collection('users').doc(user.id).set({
        'uid': user.id,
        'email': user.email,
        'fullName': user.fullName,
        'mobileNumber': user.mobileNumber,
      });
      emit(AuthSuccess(user.toString()));
      router.go(AppRouter.verifyAccountPage);
    });
  }

  void performSignIn(String email, String password) async {
    emit(AuthLoading());
    final result = await signIn(email, password);
    result.fold((failure) => emit(AuthFailure(failure.toString())), (user) {
      emit(AuthSuccess(user.toString()));
      router.go(AppRouter.navigationBarPage);
    });
  }

  void performVerification(String mobileNumber, String otp) async {
    emit(AuthLoading());
    final result = await verifyOTP(mobileNumber, otp);
    result.fold((failure) => emit(AuthFailure(failure.toString())), (success) {
      emit(AuthSuccess(success.toString()));
      router.go(AppRouter.signInPage);
    });
  }

  void performForgotPassword(String email) async {
    emit(AuthLoading());
    final result = await resetPassword(email);
    result.fold((failure) => emit(AuthFailure(failure.toString())), (success) {
      emit(AuthSuccess(success.toString()));
      router.go(AppRouter.signInPage);
    });
  }
}
