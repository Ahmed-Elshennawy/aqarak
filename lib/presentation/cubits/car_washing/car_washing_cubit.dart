import 'package:aqarak/domain/entities/car_wash_location_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'car_washing_state.dart';

class CarWashingCubit extends Cubit<CarWashingState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CarWashingCubit() : super(CarWashingInitial());

  Future<void> fetchCarWashLocations() async {
    if (!isClosed) {
      emit(CarWashingLoading());
      try {
        final snapshot = await _firestore
            .collection('car_washing_locations')
            .where('userId', isEqualTo: _auth.currentUser?.uid)
            .get();
        final locations = snapshot.docs.map((doc) => CarWashLocationEntity.fromJson(doc.data())).toList();
        emit(CarWashingLoaded(locations));
      } catch (e) {
        emit(CarWashingError('Failed to load locations: $e'));
      }
    }
  }
}