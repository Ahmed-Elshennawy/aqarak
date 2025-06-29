import 'package:aqarak/domain/entities/car_wash_location_entity.dart';

abstract class CarWashRepository {
  Future<List<CarWashLocationEntity>> getCarWashLocations(String userId);
}
