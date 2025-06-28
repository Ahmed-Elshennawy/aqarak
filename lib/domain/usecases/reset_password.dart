import 'package:aqarak/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPassword {
  final AuthRepository repository;

  ResetPassword({required this.repository});

  Future<Either<Exception, bool>> call(String email) {
    return repository.resetPassword(email);
  }
}
