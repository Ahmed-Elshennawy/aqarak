import 'package:aqarak/domain/entities/user_model.dart';
import 'package:aqarak/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignIn {
  final AuthRepository repository;

  SignIn({required this.repository});

  Future<Either<Exception, UserModel>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
