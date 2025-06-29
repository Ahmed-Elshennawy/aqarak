// property_type_toggle.dart
import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/presentation/cubits/find_room/property_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomToggles extends StatelessWidget {
  const CustomToggles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyTypeCubit(),
      child: BlocBuilder<PropertyTypeCubit, PropertyType>(
        builder: (context, currentType) {
          return SizedBox(
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final toggleWidth = (constraints.maxWidth / 2) - 4;
                return ToggleButtons(
                  isSelected: [
                    currentType == PropertyType.hotels,
                    currentType == PropertyType.villas,
                  ],
                  onPressed: (index) {
                    final newType = index == 0
                        ? PropertyType.hotels
                        : PropertyType.villas;
                    context.read<PropertyTypeCubit>().selectPropertyType(
                      newType,
                    );
                  },
                  constraints: BoxConstraints(
                    minWidth: toggleWidth,
                    minHeight: 42,
                  ),
                  color: Colors.black,
                  selectedColor: Colors.white,
                  fillColor: AppColors.activeTabColoreColor,
                  borderRadius: BorderRadius.circular(20),
                  borderColor: AppColors.activeTabColoreColor,
                  borderWidth: 2,
                  selectedBorderColor:AppColors.activeTabColoreColor,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Hotels', style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Villas', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
