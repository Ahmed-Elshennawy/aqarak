import 'dart:developer';

import 'package:aqarak/data/datasources/home_remote_datasource.dart';
import 'package:aqarak/domain/entities/user_profile_model.dart';
import 'package:aqarak/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Exception, UserProfile>> fetchUserProfile(String uid) async {
    try {
      final userProfile = await homeRemoteDataSource.fetchUserProfile(uid);
      return Right(userProfile);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await homeRemoteDataSource.logout();
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
