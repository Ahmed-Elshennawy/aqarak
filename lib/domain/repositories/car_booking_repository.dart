import 'package:aqarak/domain/entities/car_booking_entity.dart';

abstract class CarBookingRepository {
  Future<List<CarBookingEntity>> getCarBookings(String userId);
}