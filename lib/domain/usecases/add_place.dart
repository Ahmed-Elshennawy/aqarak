import 'package:aqarak/data/models/place_model.dart';
import 'package:dartz/dartz.dart';
import '../entities/place.dart';
import '../repositories/place_repository.dart';

class AddPlace {
  final PlaceRepository repository;

  AddPlace(this.repository);

  Future<Either<Exception, void>> call(Place place) async {
    try {
      final placeModel = PlaceModel.fromEntity(place);
      await repository.addPlace(placeModel);
      return Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
