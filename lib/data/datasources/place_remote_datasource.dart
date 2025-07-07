import 'package:aqarak/data/models/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlaceModel>> getPlaces() async {
    final querySnapshot = await _firestore
        .collection('places')
        .orderBy('__name__')
        .get();

    return querySnapshot.docs
        .map((doc) => PlaceModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<PlaceModel>> searchPlaces({
    required String location,
    required String type,
    required bool isAirConditioned,
  }) async {
    final querySnapshot = await _firestore
        .collection('places')
        .where('location', isEqualTo: location)
        .where('type', isEqualTo: type)
        .where('isAirConditioned', isEqualTo: isAirConditioned)
        .orderBy('__name__')
        .get();

    return querySnapshot.docs
        .map((doc) => PlaceModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<PlaceModel>> getPlacesByLocation(String location) async {
    Query query = _firestore
        .collection('places')
        .where('location', isEqualTo: location);

    final snapshot = await query.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      if (data is Map<String, dynamic>) {
        return PlaceModel.fromJson(data);
      } else {
        throw Exception('Invalid document data format');
      }
    }).toList();
  }

  Future<void> addPlace(PlaceModel place) async {
    await _firestore.collection('places').doc(place.id).set(place.toJson());
  }
}
