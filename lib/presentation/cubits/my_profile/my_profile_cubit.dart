import 'package:aqarak/domain/entities/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyProfileCubit() : super(MyProfileInitial());

  Future<void> fetchUserProfile() async {
    if (!isClosed) {
      emit(MyProfileLoading());
      try {
        final snapshot = await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .get();
        if (snapshot.exists) {
          emit(MyProfileLoaded(UserProfile.fromJson(snapshot.data()!)));
        } else {
          emit(MyProfileError('User profile not found'));
        }
      } catch (e) {
        emit(MyProfileError('Failed to load profile: $e'));
      }
    }
  }
}
