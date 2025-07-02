import 'dart:developer';

import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:aqarak/presentation/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DifferentSignToAppAndTerms extends StatelessWidget {
  const DifferentSignToAppAndTerms({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
      if (googleUser != null) {
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
      } else {
        CustomSnackBar.show(context, 'Sign in cancelled');
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
                  onPressed: () {
                    // Add Facebook logic if needed
                  },
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
