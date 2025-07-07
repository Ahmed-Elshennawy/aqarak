import 'package:dartz/dartz.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class GetPlaces {
  final PlaceRepository repository;

  GetPlaces(this.repository);

  Future<Either<Exception, List<Place>>> call() async {
    return await repository.getPlaces();
  }
}
