import 'dart:developer';

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
      log('AuthRepository: Attempting signUp with email: $email');
      final user = await remoteDataSource.signUp(
        email,
        password,
        fullName,
        mobileNumber,
      );
      log('AuthRepository: SignUp successful for user: ${user.id}');
      return Right(user);
    } catch (e) {
      log('AuthRepository: SignUp failed: $e');
      return Left(Exception('Sign Up Failed: $e'));
    }
  }

  @override
  Future<Either<Exception, UserModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      log('AuthRepository: Attempting signIn with email: $email');
      final user = await remoteDataSource.signIn(email, password);
      log('AuthRepository: SignIn successful for user: ${user.id}');
      return Right(user);
    } catch (e) {
      log('AuthRepository: SignIn failed: $e');
      return Left(Exception('Sign In Failed: $e'));
    }
  }

  @override
  Future<Either<Exception, bool>> verifyOTP(
    String mobileNumber,
    String otp,
  ) async {
    try {
      log('AuthRepository: Attempting OTP verification for: $mobileNumber');
      final success = await remoteDataSource.verifyOTP(mobileNumber, otp);
      log('AuthRepository: OTP verification successful');
      return Right(success);
    } catch (e) {
      log('AuthRepository: OTP verification failed: $e');
      return Left(Exception('OTP verification failed: $e'));
    }
  }

  @override
  Future<Either<Exception, bool>> resetPassword(String email) async {
    try {
      log('AuthRepository: Attempting password reset for: $email');
      final success = await remoteDataSource.resetPassword(email);
      log('AuthRepository: Password reset successful');
      return Right(success);
    } catch (e) {
      log('AuthRepository: Password reset failed: $e');
      return Left(Exception('Password reset failed: $e'));
    }
  }
}
