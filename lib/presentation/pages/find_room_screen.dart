import 'dart:developer';
import 'package:aqarak/data/datasources/place_remote_datasource.dart';
import 'package:aqarak/data/repositories/place_repository_impl.dart';
import 'package:aqarak/domain/usecases/add_place.dart';
import 'package:aqarak/domain/usecases/get_places_by_location.dart';
import 'package:aqarak/domain/usecases/search_places.dart';
import 'package:aqarak/presentation/cubits/find_room/property_type_cubit.dart';
import 'package:aqarak/presentation/cubits/find_room/room_type_cubit.dart';
import 'package:aqarak/presentation/cubits/search_places_cubit.dart';
import 'package:aqarak/presentation/pages/add_place_screen_test.dart';
import 'package:aqarak/presentation/widgets/custom_app_bar.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
import 'package:aqarak/presentation/widgets/custom_snack_bar.dart';
import 'package:aqarak/presentation/widgets/custom_toggles.dart';
import 'package:aqarak/presentation/widgets/horizontal_card_list.dart';
import 'package:aqarak/presentation/widgets/location_search_feild.dart';
import 'package:aqarak/presentation/widgets/room_type_selector.dart';
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
      create: (context) => SearchPlacesCubit(
        searchPlaces: SearchPlaces(
          PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
        ),
        getPlacesByLocation: GetPlacesByLocation(
          PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
        ),
        addPlace: AddPlace(
          PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PropertyTypeCubit()),
          BlocProvider(create: (context) => RoomTypeCubit()),
        ],
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
                    const SizedBox(height: AppSizes.padding),
                    LocationSearchField(
                      key: locationSearchKey,
                      onLocationSelected: (location) {
                        context.read<SearchPlacesCubit>().loadNearbyPlaces(
                          location,
                        );
                      },
                    ),
                    const SizedBox(height: AppSizes.padding),
                    const RoomTypeSelector(),
                    Divider(),
                    const SizedBox(height: AppSizes.padding),
                    BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
                      builder: (context, state) {
                        return CustomButton(
                          onPressed: () {
                            final location =
                                locationSearchKey
                                    .currentState
                                    ?.controller
                                    .text ??
                                '';
                            final type =
                                context.read<PropertyTypeCubit>().state ==
                                    PropertyType.hotels
                                ? 'Hotel'
                                : 'Villa';
                            final isAirConditioned = context
                                .read<RoomTypeCubit>()
                                .state;

                            log(
                              'Search params - location: $location, type: $type, isAirConditioned: $isAirConditioned',
                            );

                            if (location.isNotEmpty) {
                              context.read<SearchPlacesCubit>().search(
                                location: location,
                                type: type,
                                isAirConditioned: isAirConditioned,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a location.'),
                                ),
                              );
                            }
                          },
                          text: 'Search',
                          isLoading: state is SearchPlacesLoading,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
                      builder: (context, state) {
                        if (state is SearchPlacesLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is SearchPlacesLoaded) {
                          return HorizontalCardList(
                            sectionTitle: 'Search Results',
                            items: state.places
                                .map(
                                  (place) => {
                                    'imageUrl': place.imageUrl,
                                    'title': place.name,
                                  },
                                )
                                .toList(),
                          );
                        } else if (state is SearchPlacesError) {
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
                    BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
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
                                    .read<SearchPlacesCubit>()
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
                    BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
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
                                    .read<SearchPlacesCubit>()
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
