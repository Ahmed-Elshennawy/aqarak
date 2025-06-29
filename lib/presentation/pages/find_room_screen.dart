import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/presentation/cubits/find_room/property_type_cubit.dart';
import 'package:aqarak/presentation/widgets/custom_app_bar.dart';
import 'package:aqarak/presentation/widgets/custom_toggles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindRoomScreen extends StatelessWidget {
  const FindRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CUSTOM APP BAR
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              children: [
                // CUSTOM TOGGLE TYPE TABS
                BlocProvider(
                  create: (context) => PropertyTypeCubit(),
                  child: CustomToggles(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
