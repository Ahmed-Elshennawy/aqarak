import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'find_room_state.dart';

class FindRoomCubit extends Cubit<FindRoomState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FindRoomCubit() : super(FindRoomInitial());

  Future<void> fetchRooms() async {
    if (!isClosed) {
      emit(FindRoomLoading());
      try {
        final snapshot = await _firestore
            .collection('rooms')
            .where('userId', isEqualTo: _auth.currentUser?.uid)
            .get();
        final rooms = snapshot.docs.map((doc) => doc.data()).toList();
        emit(FindRoomLoaded(rooms));
      } catch (e) {
        emit(FindRoomError('Failed to fetch rooms $e'));
      }
    }
  }
}
