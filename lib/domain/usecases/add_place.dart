import 'package:dartz/dartz.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class AddPlace {
  final PlaceRepository repository;

  AddPlace(this.repository);

  Future<Either<Exception, void>> call(Place place) async {
    return await repository.addPlace(place);
  }
}
