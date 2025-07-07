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
import 'package:aqarak/presentation/widgets/shimmer_place_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class FindRoomScreen extends StatelessWidget {
  const FindRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        cubit.getAllPlaces();
        cubit.getNearbyPlaces("Alexandria, Egypt");
        cubit.getBestPlaces("Cairo, Egypt");
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
                    // HOTELS OR VILLAS BUTTONS
                    CustomToggles(),
                    const SizedBox(height: AppSizes.padding),
                    // ALL PLACES FROM API
                    BlocBuilder<PlacesCubit, PlacesState>(
                      builder: (context, state) {
                        if (state.status == PlacesStatus.loading &&
                            state.operation == PlaceOperation.allPlaces) {
                          return HorizontalCardList(
                            sectionTitle: 'Places',
                            items: List.generate(
                              4,
                              (_) => {'imageUrl': '', 'title': ''},
                            ),
                            itemBuilder: (context, index) => ShimmerPlaceCard(),
                          );
                        }
                        if (state.places.isNotEmpty) {
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
                        }
                        if (state.status == PlacesStatus.error &&
                            state.operation == PlaceOperation.allPlaces) {
                          CustomSnackBar.show(
                            context,
                            'Can\'t Find Places, please try again.',
                          );
                          log('Error message ${state.errorMessage}');
                        }
                        return HorizontalCardList(
                          sectionTitle: 'Places',
                          items: [],
                        );
                      },
                    ),
                    const Divider(
                      color: AppColors.findRoomDividerColor,
                      height: 2,
                      thickness: 3,
                    ),
                    const SizedBox(height: AppSizes.padding),
                    // THE PLACES IN YOUR LOCATION
                    BlocBuilder<PlacesCubit, PlacesState>(
                      builder: (context, state) {
                        if (state.status == PlacesStatus.loading &&
                            state.operation == PlaceOperation.nearbyPlaces) {
                          return HorizontalCardList(
                            sectionTitle: 'Explore Nearby',
                            items: List.generate(
                              4,
                              (_) => {'imageUrl': '', 'title': ''},
                            ),
                            itemBuilder: (context, index) => ShimmerPlaceCard(),
                          );
                        }
                        if (state.nearbyPlaces.isNotEmpty) {
                          return HorizontalCardList(
                            sectionTitle: 'Explore Nearby',
                            items: state.places
                                .map(
                                  (place) => {
                                    'imageUrl': place.imageUrl,
                                    'title': place.name,
                                  },
                                )
                                .toList(),
                          );
                        }
                        if (state.status == PlacesStatus.error &&
                            state.operation == PlaceOperation.nearbyPlaces) {
                          return Column(
                            children: [
                              Text(
                                state.errorMessage ??
                                    'Error loading nearby places',
                              ),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<PlacesCubit>()
                                    .getNearbyPlaces("Alexandria, Egypt"),
                                child: const Text('Retry'),
                              ),
                            ],
                          );
                        }
                        return HorizontalCardList(
                          sectionTitle: 'Explore Nearby',
                          items: [],
                        );
                      },
                    ),
                    const Divider(
                      color: AppColors.findRoomDividerColor,
                      height: 2,
                      thickness: 3,
                    ),
                    const SizedBox(height: AppSizes.padding),
                    // BEST PLACES
                    BlocBuilder<PlacesCubit, PlacesState>(
                      builder: (context, state) {
                        if (state.status == PlacesStatus.loading &&
                            state.operation == PlaceOperation.bestPlaces) {
                          return HorizontalCardList(
                            sectionTitle: 'Best Places',
                            items: List.generate(
                              4,
                              (_) => {'imageUrl': '', 'title': ''},
                            ),
                            itemBuilder: (context, index) => ShimmerPlaceCard(),
                            onViewAll: () => context.read<PlacesCubit>(),
                          );
                        }
                        if (state.bestPlaces.isNotEmpty) {
                          return HorizontalCardList(
                            sectionTitle: 'Best Places',
                            items: state.places
                                .map(
                                  (place) => {
                                    'imageUrl': place.imageUrl,
                                    'title': place.name,
                                  },
                                )
                                .toList(),
                            onViewAll: () => context.read<PlacesCubit>(),
                          );
                        }
                        if (state.status == PlacesStatus.error &&
                            state.operation == PlaceOperation.bestPlaces) {
                          return Column(
                            children: [
                              Text(
                                state.errorMessage ??
                                    'Error loading best places',
                              ),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<PlacesCubit>()
                                    .getBestPlaces("Cairo, Egypt"),
                                child: const Text('Retry'),
                              ),
                            ],
                          );
                        }
                        return HorizontalCardList(
                          sectionTitle: 'Best Places',
                          items: [],
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
