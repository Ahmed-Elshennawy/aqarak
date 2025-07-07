import 'package:aqarak/data/models/place_model.dart';
import 'package:dartz/dartz.dart';
import '../entities/place.dart';

abstract class PlaceRepository {
  Future<Either<Exception, List<Place>>> getPlaces();

  Future<Either<Exception, List<Place>>> searchPlaces({
    required String location,
    required String type,
    required bool isAirConditioned,
  });

  Future<Either<Exception, List<Place>>> getPlacesByLocation(String location);

  Future<Either<Exception, void>> addPlace(PlaceModel place);
}
