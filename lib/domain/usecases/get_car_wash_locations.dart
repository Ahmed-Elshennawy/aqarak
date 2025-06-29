import 'package:aqarak/domain/entities/car_wash_location_entity.dart';
import 'package:aqarak/domain/repositories/car_wash_repository.dart';

class GetCarWashLocations {
  final CarWashRepository repository;
  GetCarWashLocations(this.repository);

  Future<List<CarWashLocationEntity>> call(String userId) async {
    return await repository.getCarWashLocations(userId);
  }
}