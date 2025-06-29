import 'package:aqarak/domain/entities/room_entity.dart';
import 'package:aqarak/domain/repositories/room_repository.dart';

class GetRooms {
  final RoomRepository repository;
  GetRooms(this.repository);

  Future<List<RoomEntity>> call(String userId) async {
    return await repository.getRooms(userId);
  }
}
