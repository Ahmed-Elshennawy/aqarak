import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class FindRoomScreen extends StatelessWidget {
  const FindRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
