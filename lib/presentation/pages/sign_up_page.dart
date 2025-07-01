// lib/presentation/pages/sign_up_page.dart
import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/presentation/cubits/auth/auth_cubit.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
import 'package:aqarak/presentation/widgets/custom_snack_bar.dart';
import 'package:aqarak/presentation/widgets/custom_text_field.dart';
import 'package:aqarak/presentation/widgets/different_sign_to_app_and_terms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/extensions/context_extensions.dart';

/// Sign-up screen for new users with form fields and social login options.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            CustomSnackBar.show(context, 'Account created successfully!');
            GoRouter.of(context).go(AppRouter.verifyAccountPage);
          } else if (state is AuthFailure) {
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
                  Text(AppStrings.signUpTitle, style: AppFonts.titlePageName),
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
                            const SizedBox(height: AppSizes.padding),
                            CustomTextField(
                              controller: _fullNameController,
                              labelText: AppStrings.fullName,
                              prefixIcon: Icons.person_outline,
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Full name is required'
                                  : null,
                            ),
                            const SizedBox(height: AppSizes.padding),
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
                            const SizedBox(height: AppSizes.padding),
                            CustomTextField(
                              controller: _mobileController,
                              labelText: AppStrings.mobileNumber,
                              prefixIcon: Icons.phone_outlined,
                              validator: (value) =>
                                  !RegExp(
                                    r'^\+?[1-9]\d{9,14}$',
                                  ).hasMatch(value ?? '')
                                  ? 'Enter a valid mobile number'
                                  : null,
                            ),
                            const SizedBox(height: AppSizes.padding),
                            CustomTextField(
                              controller: _passwordController,
                              labelText: AppStrings.password,
                              prefixIcon: Icons.lock_outline,
                              validator: (value) => (value?.length ?? 0) < 6
                                  ? 'Password must be at least 6 characters'
                                  : null,
                              obscureText: true,
                            ),
                            const SizedBox(height: AppSizes.padding),
                            CustomButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().performSignUp(
                                    _emailController.text,
                                    _passwordController.text,
                                    _fullNameController.text,
                                    _mobileController.text,
                                  );
                                }
                              },
                              text: AppStrings.createAccount,
                              isLoading: state is AuthLoading,
                            ),
                            const SizedBox(height: 60),
                            DifferentSignToAppAndTerms(),
                            const SizedBox(height: AppSizes.padding),
                            TextButton(
                              onPressed: () =>
                                  GoRouter.of(context).go(AppRouter.signInPage),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Already have an account? ',
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
    if (errorMessage.contains('user-not-found')) {
      return 'No account found with this email. Please sign up first.';
    }
    if (errorMessage.contains('wrong-password')) {
      return 'The password you entered is incorrect. Please try again.';
    }
    if (errorMessage.contains('invalid-email')) {
      return 'The email address is not valid. Please check and try again.';
    }
    if (errorMessage.contains('email-already-in-use')) {
      return 'This email is already registered. Please sign in or reset your password.';
    }
    if (errorMessage.contains('weak-password')) {
      return 'Your password is too weak. Please choose a stronger password.';
    }
    if (errorMessage.contains('too-many-requests')) {
      return 'We’ve detected unusual activity. Please wait a moment before trying again.';
    }
    if (errorMessage.contains('network-request-failed')) {
      return 'Network error. Please check your internet connection.';
    }
    if (errorMessage.contains('account-exists-with-different-credential')) {
      return 'An account already exists with a different sign-in method. Try another way.';
    }
    if (errorMessage.contains('invalid-credential')) {
      return 'Your sign-in credentials are invalid or have expired.';
    }
    if (errorMessage.contains('operation-not-allowed')) {
      return 'This sign-in method is not enabled. Please contact support.';
    }

    return 'An unexpected error occurred. Please try again.';
  }
}
