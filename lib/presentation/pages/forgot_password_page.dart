import 'dart:developer';

import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/presentation/cubits/auth/auth_cubit.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
import 'package:aqarak/presentation/widgets/custom_snack_bar.dart';
import 'package:aqarak/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/extensions/context_extensions.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            log('Password reset email sent successfully');
            CustomSnackBar.show(
              context,
              'Password reset email sent to ${_emailController.text}',
            );
            context.go(AppRouter.signInPage);
          } else if (state is AuthFailure) {
            log('Password reset failed: ${state.message}');
            CustomSnackBar.show(context, _parseFirebaseError(state.message));
          }
        },
        builder: (context, state) {
          return Container(
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryGreen, AppColors.primaryBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    AppStrings.forgotPasswordTitle,
                    style: AppFonts.titlePageName,
                  ),
                  const SizedBox(height: AppSizes.padding),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.padding),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 50),
                            Text(
                              AppStrings.recoverEmail,
                              style: AppFonts.noteStyle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 35),
                            CustomTextField(
                              controller: _emailController,
                              labelText: AppStrings.email,
                              prefixIcon: Icons.email_outlined,
                              validator: (value) =>
                                  !RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value ?? '')
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                            const SizedBox(height: 25),
                            CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  log(
                                    'Form validated, calling performForgotPassword with email: ${_emailController.text}',
                                  );
                                  context
                                      .read<AuthCubit>()
                                      .performForgotPassword(
                                        _emailController.text,
                                      );
                                } else {
                                  log('Form validation failed');
                                }
                              },
                              text: AppStrings.submit,
                            ),
                            const SizedBox(height: 50),
                            TextButton(
                              onPressed: () =>
                                  GoRouter.of(context).go(AppRouter.signInPage),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Back to ',
                                  style: AppFonts.noteStyle,
                                  children: [
                                    TextSpan(
                                      text: 'Sign In',
                                      style: AppFonts.noteStyle.copyWith(
                                        color: AppColors.accentBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _parseFirebaseError(String errorMessage) {
    log('Parsing error: $errorMessage');
    if (errorMessage.contains('user-not-found')) {
      return 'No account found with this email. Please sign up first.';
    }
    if (errorMessage.contains('invalid-email')) {
      return 'The email address is not valid. Please check and try again.';
    }
    if (errorMessage.contains('too-many-requests')) {
      return 'Too many requests. Please wait a moment before trying again.';
    }
    if (errorMessage.contains('network-request-failed')) {
      return 'Network error. Please check your internet connection.';
    }
    if (errorMessage.contains('operation-not-allowed')) {
      return 'Password reset is not enabled. Please contact support.';
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
