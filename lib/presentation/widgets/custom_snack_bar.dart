import 'dart:async';
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    // Remove any existing snackbar
    hide();

    // Create overlay entry
    _overlayEntry = OverlayEntry(
      builder: (context) =>
          TopSnackBar(message: message, duration: duration, onDismissed: hide),
    );

    // Insert overlay
    Overlay.of(context).insert(_overlayEntry!);

    // Auto hide after duration
    _timer = Timer(duration, hide);
  }

  static void hide() {
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class TopSnackBar extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback onDismissed;

  const TopSnackBar({
    required this.message,
    required this.duration,
    required this.onDismissed,
    super.key,
  });

  @override
  TopSnackBarState createState() => TopSnackBarState();
}

class TopSnackBarState extends State<TopSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();

    // Start dismiss animation slightly before the duration ends
    Future.delayed(widget.duration - const Duration(milliseconds: 250), () {
      if (mounted) {
        _animationController.reverse();
      }
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.onDismissed();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SlideTransition(
        position: _offsetAnimation,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: size.width * 0.15),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textLight,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textDark, fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
