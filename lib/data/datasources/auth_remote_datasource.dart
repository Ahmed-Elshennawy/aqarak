import 'package:firebase_auth/firebase_auth.dart';
import 'package:aqarak/domain/entities/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signUp(
    String email,
    String password,
    String fullName,
    String mobileNumber,
  ) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.updateDisplayName(fullName);
    return UserModel(
      id: userCredential.user?.uid,
      email: email,
      fullName: fullName,
      mobileNumber: mobileNumber,
    );
  }

  Future<UserModel> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(id: userCredential.user?.uid, email: email);
  }

  Future<bool> verifyOTP(String mobileNumber, String otp) async {
    // Implement phone authentication with Firebase
    // This is a placeholder; use verifyPhoneNumber API
    return true;
  }

  Future<bool> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return true;
  }
}
