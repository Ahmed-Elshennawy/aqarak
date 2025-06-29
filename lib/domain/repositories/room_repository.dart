import 'package:aqarak/domain/entities/room_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getRooms(String userId);
}