import 'package:aqarak/data/models/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../entities/place.dart';

abstract class PlaceRepository {
  Future<Either<Exception, List<Place>>> getPlaces();

  Future<Either<Exception, List<Place>>> searchPlaces({
    required String location,
    required String type,
    required bool isAirConditioned,
  });

  Future<Either<Exception, List<Place>>> getPlacesByLocation(
    String location, {
    int limit,
    DocumentSnapshot? lastDoc,
  });

  Future<Either<Exception, List<Place>>> getAllPlaces({
    int limit,
    DocumentSnapshot? lastDoc,
  });

  Future<Either<Exception, void>> addPlace(PlaceModel place);
}
