// lib/presentation/pages/verify_account_page.dart
import 'dart:async';
import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/extensions/context_extensions.dart';

/// Screen for verifying a user's account using an OTP sent to their mobile number.
class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  int _timerSeconds = 30;
  late Timer _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          _canResend = true;
          _timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, color: AppColors.primaryBlue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(color: AppColors.accentBlue),
      ),
    );

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
                        AppStrings.verifyMobile,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.padding),
                      Text(
                        AppStrings.otpSent,
                        style: AppFonts.noteStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: _formKey,
                        child: Pinput(
                          length: 6,
                          controller: _pinController,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              border: Border.all(
                                color: AppColors.accentBlue,
                                width: 2,
                              ),
                            ),
                          ),
                          onCompleted: (pin) {
                            // Placeholder for OTP verification logic
                            // context.read<AuthCubit>().performVerification(mobileNumber, pin);
                          },
                          validator: (value) => value!.length < 6
                              ? 'Please enter full OTP'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 145,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _canResend
                                  ? () {
                                      setState(() {
                                        _timerSeconds = 30;
                                        _canResend = false;
                                        _startTimer();
                                      });
                                      // Placeholder for resend OTP logic
                                      // context.read<AuthCubit>().resendOTP(mobileNumber);
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _canResend
                                    ? AppColors.primaryGreen
                                    : AppColors.primaryBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.borderRadius,
                                  ),
                                ),
                              ),
                              child: Text(
                                _canResend
                                    ? 'Resend'
                                    : 'Resend in $_timerSeconds s',
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.padding),
                          SizedBox(
                            width: 150,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () => context.go(AppRouter.signUpPage),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accentBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.borderRadius,
                                  ),
                                ),
                              ),
                              child: Text(AppStrings.changeNumber),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
