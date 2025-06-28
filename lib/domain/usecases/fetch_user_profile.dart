import 'package:aqarak/domain/entities/user_profile_model.dart';
import 'package:aqarak/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class FetchUserProfile {
  final HomeRepository repository;

  const FetchUserProfile(this.repository);

  Future<Either<Exception, UserProfile>> call(String uid) {
    return repository.fetchUserProfile(uid);
  }
}
