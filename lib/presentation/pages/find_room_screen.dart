import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_images.dart';
import 'package:aqarak/core/constants/app_sizes.dart';
import 'package:aqarak/presentation/cubits/find_room/property_type_cubit.dart';
import 'package:aqarak/presentation/widgets/custom_app_bar.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
import 'package:aqarak/presentation/widgets/custom_toggles.dart';
import 'package:aqarak/presentation/widgets/guest_selector.dart';
import 'package:aqarak/presentation/widgets/horizontal_card_list.dart';
import 'package:aqarak/presentation/widgets/location_search_feild.dart';
import 'package:aqarak/presentation/widgets/room_type_selector.dart';
import 'package:aqarak/presentation/widgets/stay_dates_selector.dart';
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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // CUSTOM TOGGLE TYPE TABS
                BlocProvider(
                  create: (context) => PropertyTypeCubit(),
                  child: CustomToggles(),
                ),
                SizedBox(height: AppSizes.padding),
                // SELECT PLACE TEXT FEILD.
                LocationSearchField(),
                SizedBox(height: AppSizes.padding),
                // SELECT DATES FOR STAY
                StayDatesSelector(),
                // SELECT PEOPLE COUNT AND ROOMS COUNT
                GuestsSelector(),
                // SELECT IF FAN OR AIR CONDITIONED
                RoomTypeSelector(),
                // THE SEARCH BUTTON
                CustomButton(onPressed: () {}, text: 'Search'),
                SizedBox(height: 10),
                // PLACES CLOSE TO YOUR LOCATION
                HorizontalCardList(
                  sectionTitle: 'Explore Nearby',
                  items: [
                    {'imageUrl': AppImages.homeTest1, 'title': 'Ivory Coast'},
                    {'imageUrl': AppImages.homeTest1, 'title': 'Senegal'},
                    {'imageUrl': AppImages.homeTest1, 'title': 'Ville'},
                    {'imageUrl': AppImages.homeTest1, 'title': 'Lagos'},
                  ],
                ),
                Divider(
                  color: AppColors.findRoomDividerColor,
                  height: 2,
                  thickness: 3,
                ),
                // BEST PLACES
                HorizontalCardList(
                  sectionTitle: 'Best Places',
                  items: [
                    {'imageUrl': AppImages.homeTest, 'title': 'Heden golf'},
                    {'imageUrl': AppImages.homeTest, 'title': 'Onomo'},
                    {'imageUrl': AppImages.homeTest, 'title': 'Adagio'},
                    {'imageUrl': AppImages.homeTest, 'title': 'Sofiltel'},
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
