import 'package:aqarak/domain/entities/user_profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Exception, UserProfile>> fetchUserProfile(String uid);
  Future<void> logout();
}
