import 'package:aqarak/data/datasources/room_remote_datasource.dart';
import 'package:aqarak/domain/entities/room_entity.dart';
import 'package:aqarak/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDatasource datasource;

  RoomRepositoryImpl(this.datasource);

  @override
  Future<List<RoomEntity>> getRooms(String userId) async {
    try {
      return await datasource.getRooms(userId);
    } catch (e) {
      throw Exception('Failed to fetch rooms $e');
    }
  }
}
