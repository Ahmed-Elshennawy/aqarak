import 'package:aqarak/presentation/cubits/car_washing/car_washing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarWashingScreen extends StatelessWidget {
  const CarWashingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarWashingCubit()..fetchCarWashLocations(),
      child: Scaffold(
        body: BlocBuilder<CarWashingCubit, CarWashingState>(
          builder: (context, state) {
            if (state is CarWashingLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CarWashingLoaded) {
              return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 10,
                ),
                markers: state.locations
                    .map(
                      (loc) => Marker(
                        markerId: MarkerId(loc.id),
                        position: LatLng(
                          0,
                          0,
                        ), // Replace with actual coordinates
                        infoWindow: InfoWindow(title: loc.name),
                      ),
                    )
                    .toSet(),
              );
            }
            if (state is CarWashingError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Tap to load car wash locations'));
          },
        ),
      ),
    );
  }
}
