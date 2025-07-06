import 'package:aqarak/data/datasources/loca_datassources/place_local_datastore.dart';
import 'package:aqarak/data/datasources/remote_datasources/place_remote_datasource.dart';
import 'package:aqarak/domain/entities/place.dart';
import 'package:aqarak/domain/repositories/place_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../models/place_model.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final PlaceRemoteDataSource remoteDataSource;
  final PlaceLocalDataSource localDataSource;

  PlaceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

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
      await localDataSource.cachePlaces(places);
      return Right(places.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Place>>> getPlacesByLocation(
    String location, {
    int limit = 10,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      final places = await remoteDataSource.getPlacesByLocation(
        location,
        limit: limit,
        lastDoc: lastDoc,
      );
      await localDataSource.cachePlaces(places);
      return Right(places.map((model) => model.toEntity()).toList());
    } catch (e) {
      final cachedPlaces = localDataSource.getCachedPlacesByLocation(location);
      if (cachedPlaces.isNotEmpty) {
        return Right(cachedPlaces.map((model) => model.toEntity()).toList());
      }
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Place>>> getAllPlaces({
    int limit = 10,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      final places = await remoteDataSource.getAllPlaces(
        limit: limit,
        lastDoc: lastDoc,
      );
      await localDataSource.cachePlaces(places);
      return Right(places.map((model) => model.toEntity()).toList());
    } catch (e) {
      final cachedPlaces = localDataSource.getCachedPlaces();
      if (cachedPlaces.isNotEmpty) {
        return Right(cachedPlaces.map((model) => model.toEntity()).toList());
      }
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
