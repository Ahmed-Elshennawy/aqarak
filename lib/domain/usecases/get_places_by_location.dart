import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class GetPlacesByLocation {
  final PlaceRepository repository;

  GetPlacesByLocation(this.repository);

  Future<Either<Exception, List<Place>>> call(
    String location, {
    int limit = 10,
    DocumentSnapshot? lastDoc,
  }) async {
    return await repository.getPlacesByLocation(
      location,
      limit: limit,
      lastDoc: lastDoc,
    );
  }
}
