import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onAddPlcasePressed;

  const CustomAppBar({super.key, this.onAddPlcasePressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: const Text('Find Room'),
      actions: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_home_outlined),
                onPressed: onAddPlcasePressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
