import 'package:aqarak/data/datasources/car_wash_remote_datasource.dart';
import 'package:aqarak/domain/entities/car_wash_location_entity.dart';
import 'package:aqarak/domain/repositories/car_wash_repository.dart';

class CarWashRepositoryImpl implements CarWashRepository {
  final CarWashRemoteDataSource dataSource;

  CarWashRepositoryImpl(this.dataSource);
  @override
  Future<List<CarWashLocationEntity>> getCarWashLocations(String userId) async {
    try {
      return await dataSource.getCarWashLocations(userId);
    } catch (e) {
      throw Exception('Failed to fetch car wash locations');
    }
  }
}
