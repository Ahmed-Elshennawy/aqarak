import 'package:aqarak/presentation/cubits/book_car/book_car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCarScreen extends StatelessWidget {
  const BookCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCarCubit()..fetchCarBookings(),
      child: Scaffold(
        body: BlocBuilder<BookCarCubit, BookCarState>(
          builder: (context, state) {
            if (state is BookCarLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is BookCarLoaded) {
              return ListView.builder(
                itemCount: state.carBookings.length,
                itemBuilder: (context, index) {
                  final booking = state.carBookings[index];
                  return ListTile(
                    title: Text(booking.pickupLocation),
                    subtitle: Text(booking.dropoffLocation),
                  );
                },
              );
            }
            if (state is BookCarError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Tap to load bookings'));
          },
        ),
      ),
    );
  }
}
