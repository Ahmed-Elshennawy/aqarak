import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class DifferentSignToAppAndTerms extends StatelessWidget {
  const DifferentSignToAppAndTerms({super.key});

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
                  onPressed: () {},
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
                      Icon(Icons.facebook, color: Colors.white, size: 20),
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
                  onPressed: () {},
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
                      Icon(Icons.g_mobiledata, color: Colors.white, size: 30),
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
