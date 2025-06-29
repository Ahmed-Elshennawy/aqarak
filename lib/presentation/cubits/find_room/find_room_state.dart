part of 'find_room_cubit.dart';

sealed class FindRoomState extends Equatable {
  const FindRoomState();

  @override
  List<Object> get props => [];
}

final class FindRoomInitial extends FindRoomState {}


final class FindRoomLoading extends FindRoomState {}

final class FindRoomLoaded extends FindRoomState {
  final List<RoomEntity> rooms;

  const FindRoomLoaded(this.rooms);
}

final class FindRoomError extends FindRoomState {
  final String message;

  const FindRoomError(this.message);
}
