import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/extensions/context_extensions.dart';
import 'package:aqarak/presentation/cubits/splash/splash_cubit.dart';
import 'package:aqarak/presentation/widgets/animated_apartment_icon.dart';
import 'package:aqarak/presentation/widgets/animated_app_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashComplete) {
          if (state.isLoggedIn) {
            GoRouter.of(context).go(AppRouter.navigationBarPage);
          } else {
            GoRouter.of(context).go(AppRouter.signUpPage);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryGreen, AppColors.primaryBlue],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedApartmentIcon(),
                const SizedBox(height: 20),
                const AnimatedAppName(),
              ],
            ),
          ),
        );
      },
    );
  }
}
