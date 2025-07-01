import 'package:dartz/dartz.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class SearchPlaces {
  final PlaceRepository repository;

  SearchPlaces(this.repository);

  Future<Either<Exception, List<Place>>> call({
    required String location,
    required String type,
    required bool isAirConditioned,

  }) async {
    return await repository.searchPlaces(
      location: location,
      type: type,
      isAirConditioned: isAirConditioned,
    );
  }
}
