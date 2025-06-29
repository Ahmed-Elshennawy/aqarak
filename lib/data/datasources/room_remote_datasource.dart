import 'package:aqarak/domain/entities/room_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<RoomEntity>> getRooms({
    String? type,
    String? location,
    bool? airConditioned,
  }) async {
    Query query = _firestore
        .collection('rooms')
        .where('userId', isEqualTo: _auth.currentUser?.uid);

    if (type != null) {
      query = query.where('type', isEqualTo: type);
    }
    if (location != null) {
      query = query.where('location', isEqualTo: location);
    }
    if (airConditioned != null) {
      query = query.where('airConditioned', isEqualTo: airConditioned);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => RoomEntity.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
