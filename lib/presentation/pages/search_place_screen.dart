
                    // LocationSearchField(
                    //   key: locationSearchKey,
                    //   onLocationSelected: (location) {
                    //     context.read<SearchPlacesCubit>().loadNearbyPlaces(
                    //       location,
                    //     );
                    //   },
                    //   isSearch: true,
                    //   label: 'Where do you want',
                    // ),
                    // const SizedBox(height: AppSizes.padding),
                    // const RoomTypeSelector(),
                    // Divider(),
                    // const SizedBox(height: AppSizes.padding),
                    // BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
                    //   builder: (context, state) {
                    //     return CustomButton(
                    //       onPressed: () {
                    //         final location =
                    //             locationSearchKey
                    //                 .currentState
                    //                 ?.controller
                    //                 .text ??
                    //             '';
                    //         final type =
                    //             context.read<PropertyTypeCubit>().state ==
                    //                 PropertyType.hotels
                    //             ? 'Hotel'
                    //             : 'Villa';
                    //         final isAirConditioned = context
                    //             .read<RoomTypeCubit>()
                    //             .state;
                    //         log(
                    //           'Search params - location: $location, type: $type, isAirConditioned: $isAirConditioned',
                    //         );
                    //         if (location.isNotEmpty) {
                    //           context.read<SearchPlacesCubit>().search(
                    //             location: location,
                    //             type: type,
                    //             isAirConditioned: isAirConditioned,
                    //           );
                    //         } else {
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             const SnackBar(
                    //               content: Text('Please select a location.'),
                    //             ),
                    //           );
                    //         }
                    //       },
                    //       text: 'Search',
                    //       isLoading: state is SearchPlacesLoading,
                    //     );
                    //   },
                    // ),
                    // const SizedBox(height: 10),
                    // BlocBuilder<SearchPlacesCubit, SearchPlacesState>(
                    //   builder: (context, state) {
                    //     if (state is SearchPlacesLoading) {
                    //       return const CircularProgressIndicator();
                    //     } else if (state is SearchPlacesLoaded) {
                    //       return HorizontalCardList(
                    //         sectionTitle: 'Search Results',
                    //         items: state.places
                    //             .map(
                    //               (place) => {
                    //                 'imageUrl': place.imageUrl,
                    //                 'title': place.name,
                    //               },
                    //             )
                    //             .toList(),
                    //       );
                    //     } else if (state is SearchPlacesError) {
                    //       CustomSnackBar.show(
                    //         context,
                    //         'Can\'t Find Places, please try again.',
                    //       );
                    //       log('Error message ${state.message}');
                    //     }
                    //     return const SizedBox.shrink();
                    //   },
                    // ),
    