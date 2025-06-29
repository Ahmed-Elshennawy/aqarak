import 'package:aqarak/data/datasources/car_booking_remote_datasource.dart';
import 'package:aqarak/domain/entities/car_booking_entity.dart';
import 'package:aqarak/domain/repositories/car_booking_repository.dart';

class CarBookingRepositoryImpl implements CarBookingRepository {
  final CarBookingRemoteDataSource dataSource;

  CarBookingRepositoryImpl(this.dataSource);
  @override
  Future<List<CarBookingEntity>> getCarBookings(String userId) async {
    try {
      return await dataSource.getCarBookings(userId);
    } catch (e) {
      throw Exception('Failed to load car bookings $e');
    }
  }
  
}