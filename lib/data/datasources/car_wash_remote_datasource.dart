import 'package:aqarak/domain/entities/car_wash_location_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarWashRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CarWashLocationEntity>> getCarWashLocations(String userId) async {
    final snapshot = await _firestore
        .collection('car_washing_locations')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => CarWashLocationEntity.fromJson(doc.data()))
        .toList();
  }
}
