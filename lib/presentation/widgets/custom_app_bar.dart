import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/presentation/cubits/find_room/custom_app_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Find Room'),
      actions: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Row(
            children: [
              // STAY PASS SWITCHER
              BlocProvider(
                create: (context) => CustomAppBarCubit(),
                child: BlocBuilder<CustomAppBarCubit, bool>(
                  builder: (context, isStaySelected) {
                    return Row(
                      children: [
                        Text(
                          'Stay',
                          style: TextStyle(
                            color: isStaySelected
                                ? AppColors.activeTabColoreColor
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Switch(
                          value: isStaySelected,
                          onChanged: (value) {
                            context.read<CustomAppBarCubit>().toggleSelection(
                              value,
                            );
                          },
                        ),
                        Text(
                          'Pass',
                          style: TextStyle(
                            color: !isStaySelected
                                ? AppColors.activeTabColoreColor
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: AppSizes.padding),
              // FILTER ICON
              Icon(Icons.filter_list),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
