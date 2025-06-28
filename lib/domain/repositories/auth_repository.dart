import 'package:aqarak/domain/entities/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserModel>> signUp(
    String email,
    String password,
    String fullName,
    String mobileNumber,
  );
  Future<Either<Exception, UserModel>> signIn(String email, String password);
  Future<Either<Exception, bool>> verifyOTP(
    String mobileNumber,
    String password,
  );
  Future<Either<Exception, bool>> resetPassword(String email);
}
