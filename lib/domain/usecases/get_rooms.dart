import 'package:aqarak/domain/entities/room_entity.dart';
import 'package:aqarak/domain/repositories/room_repository.dart';

class GetRooms {
  final RoomRepository repository;
  GetRooms(this.repository);

  Future<List<RoomEntity>> call({
    required String userId,
    String? type,
    String? location,
    bool? airConditioned,
  }) async {
    return await repository.getRooms(
      userId: userId,
      type: type,
      location: location,
      airConditioned: airConditioned,
    );
  }
}
