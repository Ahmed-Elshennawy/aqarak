import 'dart:developer';

import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:aqarak/presentation/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class DifferentSignToAppAndTerms extends StatelessWidget {
  const DifferentSignToAppAndTerms({super.key});

  Future<void> _handleFacebookSignIn(BuildContext context) async {
    try {
      log('Attempting Facebook login...');
      final LoginResult loginResult = await FacebookAuth.instance.login();
      log('Login result: $loginResult');
      if (loginResult.status == LoginStatus.success &&
          loginResult.accessToken != null) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
              loginResult
                  .accessToken!
                  .tokenString, // Use tokenString instead of token
            );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          facebookAuthCredential,
        );
        final user = userCredential.user;
        if (user != null) {
          GoRouter.of(context).go(AppRouter.navigationBarPage);
        } else {
          CustomSnackBar.show(context, 'Sign in failed');
        }
      } else if (loginResult.status == LoginStatus.cancelled) {
        CustomSnackBar.show(context, 'Sign in cancelled');
      } else {
        CustomSnackBar.show(context, 'Sign in failed: ${loginResult.message}');
      }
    } catch (e) {
      if (e is MissingPluginException) {
        CustomSnackBar.show(
          context,
          'Facebook plugin not configured correctly',
        );
      } else {
        CustomSnackBar.show(context, 'Error: $e');
      }
      log('Error during login: $e');
    }
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.emailVerified) {
          GoRouter.of(context).go(AppRouter.navigationBarPage);
        } else {
          GoRouter.of(context).go(AppRouter.verifyAccountPage);
        }
      } else {
        CustomSnackBar.show(context, 'Sign in failed');
      }
    } catch (e) {
      CustomSnackBar.show(context, 'Error: $e');
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppStrings.orSignInUsing, style: AppFonts.noteStyle),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () => _handleFacebookSignIn(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.facebookBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.facebook, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.facebook,
                        style: AppFonts.bodyLargeStyle.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () => _handleGoogleSignIn(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.googleRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.g_mobiledata,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.google,
                        style: AppFonts.bodyLargeStyle.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.padding),
        Text.rich(
          TextSpan(
            text: AppStrings.creatingAccountNote,
            style: AppFonts.noteStyle,
            children: [
              TextSpan(
                text: AppStrings.terms,
                style: AppFonts.noteStyle.copyWith(color: AppColors.accentBlue),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
