import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/presentation/cubits/auth/auth_cubit.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
import 'package:aqarak/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/extensions/context_extensions.dart';

/// Screen for recovering a forgotten password using a registered email address.
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password reset email sent')),
            );
            context.go('/sign-in');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(_parseFirebaseError(state.message))),
            );
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
                                  context
                                      .read<AuthCubit>()
                                      .performForgotPassword(
                                        _emailController.text,
                                      );
                                }
                              },
                              text: AppStrings.submit,
                              isLoading: state is AuthLoading,
                            ),
                            const SizedBox(height: 350),
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
      return 'User not found. Please sign up.';
    }
    if (errorMessage.contains('wrong-password')) {
      return 'Incorrect password. Try again.';
    }
    if (errorMessage.contains('invalid-email')) return 'Invalid email format.';
    if (errorMessage.contains('email-already-in-use')) {
      return 'Email already in use.';
    }
    return 'An error occurred. Please try again.';
  }
}
