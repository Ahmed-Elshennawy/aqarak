import 'dart:developer';

import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:aqarak/core/extensions/context_extensions.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
import 'package:aqarak/presentation/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Screen for verifying a user's account using an email verification link.
class VerifyAccountPage extends StatefulWidget {
  const VerifyAccountPage({super.key});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSending = false;

  // Send email verification link to the current user's email
  Future<void> _sendVerificationEmail() async {
    setState(() {
      _isSending = true;
    });
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        log('Verification email sent to: ${user.email}');
        CustomSnackBar.show(
          context,
          'Verification email sent to ${user.email}',
        );
        GoRouter.of(context).go(AppRouter.signInPage);
      } else {
        log('No user signed in');
        CustomSnackBar.show(
          context,
          'No user signed in. Please sign up again.',
        );
      }
    } catch (e) {
      log('Error sending verification email: $e');
      String errorMessage =
          'Failed to send verification email. Please try again.';
      if (e.toString().contains('too-many-requests')) {
        errorMessage = 'Too many requests. Please wait before trying again.';
      }
      CustomSnackBar.show(context, errorMessage);
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final email = user?.email ?? 'your email';

    return Scaffold(
      body: Container(
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
                AppStrings.verifyAccountTitle,
                style: AppFonts.titlePageName,
              ),
              const SizedBox(height: AppSizes.padding),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.padding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        'Verify Your Email',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.padding),
                      Text(
                        'A verification email has been sent to $email. Please check your inbox and click the link to verify your account.',
                        style: AppFonts.noteStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        onPressed: _isSending
                            ? null
                            : () => _sendVerificationEmail(),
                        text: 'Send Email',
                        isLoading: _isSending,
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () =>
                            GoRouter.of(context).go(AppRouter.signInPage),
                        child: Text.rich(
                          TextSpan(
                            text: 'Already verified? ',
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
            ],
          ),
        ),
      ),
    );
  }
}
