import 'package:aqarak/data/datasources/auth_remote_datasource.dart';
import 'package:aqarak/domain/entities/user_model.dart';
import 'package:aqarak/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, UserModel>> signUp(
    String email,
    String password,
    String fullName,
    String mobileNumber,
  ) async {
    try {
      final user = await remoteDataSource.signUp(
        email,
        password,
        fullName,
        mobileNumber,
      );
      return Right(user);
    } catch (e) {
      return Left(Exception('Sign Up Failed: $e'));
    }
  }

  @override
  Future<Either<Exception, UserModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.signIn(email, password);
      return Right(user);
    } catch (e) {
      return Left(Exception('Sign In Failed: $e'));
    }
  }

  @override
  Future<Either<Exception, bool>> verifyOTP(
    String mobileNumber,
    String otp,
  ) async {
    try {
      final success = await remoteDataSource.verifyOTP(mobileNumber, otp);
      return Right(success);
    } catch (e) {
      return Left(Exception('OTP verification failed: $e'));
    }
  }

  @override
  Future<Either<Exception, bool>> resetPassword(String email) async {
    try {
      final success = await remoteDataSource.resetPassword(email);
      return Right(success);
    } catch (e) {
      return Left(Exception('Password reset failed: $e'));
    }
  }
}
