import 'package:aqarak/data/datasources/place_remote_datasource.dart';
import 'package:aqarak/domain/entities/place.dart';
import 'package:aqarak/domain/repositories/place_repository.dart';
import 'package:dartz/dartz.dart';
import '../models/place_model.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;

  PlaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Exception, List<Place>>> getPlaces() async {
    try {
      final places = await remoteDataSource.getPlaces();
      return Right(places.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Place>>> searchPlaces({
    required String location,
    required String type,
    required bool isAirConditioned,
  }) async {
    try {
      final places = await remoteDataSource.searchPlaces(
        location: location,
        type: type,
        isAirConditioned: isAirConditioned,
      );
      return Right(places.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Place>>> getPlacesByLocation(
    String location,
  ) async {
    try {
      final places = await remoteDataSource.getPlacesByLocation(location);
      return Right(places.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, void>> addPlace(PlaceModel place) async {
    try {
      await remoteDataSource.addPlace(place);
      return const Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
