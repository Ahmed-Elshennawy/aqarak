import 'package:aqarak/data/datasources/room_remote_datasource.dart';
import 'package:aqarak/domain/entities/room_entity.dart';
import 'package:aqarak/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource datasource;

  RoomRepositoryImpl(this.datasource);

  @override
  Future<List<RoomEntity>> getRooms({
    required String userId,
    String? type,
    String? location,
    bool? airConditioned,
  }) async {
    try {
      return await datasource.getRooms(
        type: type,
        location: location,
        airConditioned: airConditioned,
      );
    } catch (e) {
      throw Exception('Failed to fetch rooms $e');
    }
  }
}
