import 'package:aqarak/domain/entities/car_booking_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_car_state.dart';

class BookCarCubit extends Cubit<BookCarState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BookCarCubit() : super(BookCarInitial());
  Future<void> fetchCarBookings() async {
    if (!isClosed) {
      emit(BookCarLoading());
      try {
        final snapshot = await _firestore
            .collection('car_bookings')
            .where('userId', isEqualTo: _auth.currentUser?.uid)
            .get();
        final bookings = snapshot.docs
            .map((doc) => CarBookingEntity.fromJson(doc.data()))
            .toList();
        emit(BookCarLoaded(bookings));
      } catch (e) {
        emit(BookCarError('Failed to load bookings: $e'));
      }
    }
  }
}
