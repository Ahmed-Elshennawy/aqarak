import 'package:aqarak/domain/entities/room_entity.dart';
import 'package:aqarak/domain/usecases/get_rooms.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'find_room_state.dart';

class FindRoomCubit extends Cubit<FindRoomState> {
  final GetRooms getRooms;
  FindRoomCubit({required this.getRooms}) : super(FindRoomInitial());

  Future<void> fetchRooms() async {
    if (!isClosed) {
      emit(FindRoomLoading());
      try {
        final rooms = await getRooms(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
        );
        emit(FindRoomLoaded(rooms));
      } catch (e) {
        emit(FindRoomError('Failed to load rooms: $e'));
      }
    }
  }

  Future<void> searchRooms() async {
    if (!isClosed) {
      emit(FindRoomLoading());
      try {
        final rooms = await getRooms(
          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
          type: 'Hotel',
          airConditioned: true,
        );
        emit(FindRoomLoaded(rooms));
      } catch (e) {
        emit(FindRoomError('Failed to load rooms: $e'));
      }
    }
  }
}
