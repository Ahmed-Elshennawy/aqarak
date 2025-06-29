import 'package:aqarak/domain/entities/car_booking_entity.dart';
import 'package:aqarak/domain/repositories/car_booking_repository.dart';

class GetCarBooking {
  final CarBookingRepository repository;
  GetCarBooking(this.repository);

  Future<List<CarBookingEntity>> call(String userId) async {
    return await repository.getCarBookings(userId);
  }
}
