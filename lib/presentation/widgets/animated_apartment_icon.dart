import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_images.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/presentation/cubits/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedApartmentIcon extends StatefulWidget {
  const AnimatedApartmentIcon({super.key});

  @override
  State<AnimatedApartmentIcon> createState() => _AnimatedApartmentIconState();
}

class _AnimatedApartmentIconState extends State<AnimatedApartmentIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _jumpAnimation;
  final List<double> _jumpHeights = [100, 50, 25];
  int _currentJump = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _setupAnimation();
    _controller.forward();
  }

  void _setupAnimation() {
    if (_currentJump < _jumpHeights.length) {
      _jumpAnimation =
          Tween<double>(begin: 0, end: -_jumpHeights[_currentJump]).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            ),
          )..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _currentJump++;
              if (_currentJump < _jumpHeights.length) {
                _setupAnimation();
                _controller.forward();
              } else {
                _jumpAnimation = Tween<double>(
                  begin: 0,
                  end: 0,
                ).animate(_controller);
                context.read<SplashCubit>().completeIconAnimation;
              }
            }
          });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _jumpAnimation.value),
          child: SvgPicture.asset(
            AppImages.appLogo,
            height: AppSizes.splashIconSize,
            color: AppColors.splashColorElements,
          ),
        );
      },
    );
  }
}
