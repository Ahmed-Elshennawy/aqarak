import 'package:aqarak/domain/entities/room_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RoomEntity>> getRooms(String userId) async {
    final snapshot = await _firestore
        .collection('rooms')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => RoomEntity.fromJson(doc.data())).toList();
  }
}
