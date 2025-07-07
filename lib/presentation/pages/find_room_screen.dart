import 'dart:developer';

import 'package:aqarak/data/datasources/place_remote_datasource.dart';
import 'package:aqarak/data/repositories/place_repository_impl.dart';
import 'package:aqarak/domain/usecases/add_place.dart';
import 'package:aqarak/domain/usecases/get_places.dart';
import 'package:aqarak/domain/usecases/get_places_by_location.dart';
import 'package:aqarak/domain/usecases/search_places.dart';
import 'package:aqarak/presentation/cubits/find_room/property_type_cubit.dart';
import 'package:aqarak/presentation/cubits/places_cubit.dart';
import 'package:aqarak/presentation/pages/add_place_screen.dart';
import 'package:aqarak/presentation/widgets/custom_app_bar.dart';
import 'package:aqarak/presentation/widgets/custom_snack_bar.dart';
import 'package:aqarak/presentation/widgets/custom_toggles.dart';
import 'package:aqarak/presentation/widgets/horizontal_card_list.dart';
import 'package:aqarak/presentation/widgets/location_search_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_sizes.dart';

class FindRoomScreen extends StatelessWidget {
  const FindRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationSearchKey = GlobalKey<LocationSearchFieldState>();

    return BlocProvider(
      create: (context) {
        final cubit = PlacesCubit(
          getPlaces: GetPlaces(
            PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
          ),
          searchPlaces: SearchPlaces(
            PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
          ),
          getPlacesByLocation: GetPlacesByLocation(
            PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
          ),
          addPlace: AddPlace(
            PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
          ),
        );
        cubit.places();
        return cubit;
      },
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => PropertyTypeCubit())],
        child: Scaffold(
          appBar: CustomAppBar(
            onAddPlcasePressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddPlaceScreen()),
              );
            },
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomToggles(),
                    BlocBuilder<PlacesCubit, PlacesState>(
                      builder: (context, state) {
                        if (state is PlacesLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is PlacesLoaded) {
                          return HorizontalCardList(
                            sectionTitle: 'Places',
                            items: state.places
                                .map(
                                  (place) => {
                                    'imageUrl': place.imageUrl,
                                    'title': place.name,
                                  },
                                )
                                .toList(),
                          );
                        } else if (state is PlacesError) {
                          CustomSnackBar.show(
                            context,
                            'Can\'t Find Places, please try again.',
                          );
                          log('Error message ${state.message}');
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const Divider(
                      color: AppColors.findRoomDividerColor,
                      height: 2,
                      thickness: 3,
                    ),
                    const SizedBox(height: AppSizes.padding),
                    BlocBuilder<PlacesCubit, PlacesState>(
                      builder: (context, state) {
                        if (state is NearbyPlacesLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is NearbyPlacesLoaded) {
                          return Column(
                            children: [
                              HorizontalCardList(
                                sectionTitle: 'Explore Nearby',
                                items: state.places
                                    .map(
                                      (place) => {
                                        'imageUrl': place.imageUrl,
                                        'title': place.name,
                                      },
                                    )
                                    .toList(),
                                onViewAll: () => context
                                    .read<PlacesCubit>()
                                    .loadMoreNearbyPlaces(
                                      locationSearchKey
                                              .currentState
                                              ?.controller
                                              .text ??
                                          '',
                                    ),
                              ),
                            ],
                          );
                        } else if (state is NearbyPlacesError) {
                          return Text(state.message);
                        }
                        return HorizontalCardList(
                          sectionTitle: 'Explore Nearby',
                          items: [
                            {
                              'imageUrl': AppImages.homeTest2,
                              'title': 'Ivory Coast',
                            },
                            {
                              'imageUrl': AppImages.homeTest2,
                              'title': 'Senegal',
                            },
                            {'imageUrl': AppImages.homeTest2, 'title': 'Ville'},
                            {'imageUrl': AppImages.homeTest2, 'title': 'Lagos'},
                          ],
                        );
                      },
                    ),
                    const Divider(
                      color: AppColors.findRoomDividerColor,
                      height: 2,
                      thickness: 3,
                    ),
                    const SizedBox(height: AppSizes.padding),
                    BlocBuilder<PlacesCubit, PlacesState>(
                      builder: (context, state) {
                        if (state is BestPlacesLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is BestPlacesLoaded) {
                          return Column(
                            children: [
                              HorizontalCardList(
                                sectionTitle: 'Best Places',
                                items: state.places
                                    .map(
                                      (place) => {
                                        'imageUrl': place.imageUrl,
                                        'title': place.name,
                                      },
                                    )
                                    .toList(),
                                onViewAll: () => context
                                    .read<PlacesCubit>()
                                    .loadMoreBestPlaces(),
                              ),
                            ],
                          );
                        } else if (state is BestPlacesError) {
                          return Text(state.message);
                        }
                        return HorizontalCardList(
                          sectionTitle: 'Best Places',
                          items: [
                            {
                              'imageUrl': AppImages.homeTest2,
                              'title': 'Heden golf',
                            },
                            {'imageUrl': AppImages.homeTest2, 'title': 'Onomo'},
                            {
                              'imageUrl': AppImages.homeTest2,
                              'title': 'Adagio',
                            },
                            {
                              'imageUrl': AppImages.homeTest2,
                              'title': 'Sofiltel',
                            },
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
