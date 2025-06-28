// lib/domain/entities/user.dart
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String? email;
  final String? fullName;
  final String? mobileNumber;

  const UserModel({this.id, this.email, this.fullName, this.mobileNumber});

  @override
  List<Object?> get props => [id, email, fullName, mobileNumber];
}
