import 'package:aqarak/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class VerifyOTP {
  final AuthRepository repository;

  VerifyOTP({required this.repository});

  Future<Either<Exception, bool>> call(String mobileNumber, String password) {
    return repository.verifyOTP(mobileNumber, password);
  }
}
