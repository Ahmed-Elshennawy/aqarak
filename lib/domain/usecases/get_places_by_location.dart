import 'package:dartz/dartz.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class GetPlacesByLocation {
  final PlaceRepository repository;

  GetPlacesByLocation(this.repository);

  Future<Either<Exception, List<Place>>> call(String location) async {
    return await repository.getPlacesByLocation(location);
  }
}
