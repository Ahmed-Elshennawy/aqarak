import 'package:aqarak/domain/entities/car_booking_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarBookingRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CarBookingEntity>> getCarBookings(String userId) async {
    final snapshot = await _firestore
        .collection('carBooking')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => CarBookingEntity.fromJson(doc.data()))
        .toList();
  }
}
