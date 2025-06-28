import 'package:aqarak/domain/entities/user_model.dart';
import 'package:aqarak/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUp {
  final AuthRepository repository;

  SignUp({required this.repository});

  Future<Either<Exception, UserModel>> call(
    String email,
    String password,
    String fullName,
    String mobileNumber,
  ) {
    return repository.signUp(email, password, fullName, mobileNumber);
  }
}
