import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:aqarak/presentation/cubits/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedAppName extends StatefulWidget {
  const AnimatedAppName({super.key});

  @override
  State<AnimatedAppName> createState() => _AnimatedAppNameState();
}

class _AnimatedAppNameState extends State<AnimatedAppName>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward().then((_) {
      context.read<SplashCubit>().completeAppNameAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Text(
          AppStrings.appName,
          style: AppFonts.splashAppNAme.copyWith(
            shadows: [
              Shadow(color: Colors.black, blurRadius: 10, offset: Offset(2, 2)),
            ],
          ),
        ),
      ),
    );
  }
}
