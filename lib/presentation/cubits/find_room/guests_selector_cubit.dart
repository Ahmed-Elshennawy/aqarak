import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class GuestsSelectorCubit extends Cubit<GuestsSelectorState> {
  GuestsSelectorCubit() : super(const GuestsSelectorState());

  void updateCounts({
    int? adults,
    int? children,
    int? rooms,
  }) {
    emit(state.copyWith(
      adults: adults ?? state.adults,
      children: children ?? state.children,
      rooms: rooms ?? state.rooms,
    ));
  }
}


class GuestsSelectorState extends Equatable {
  final int adults;
  final int children;
  final int rooms;

  const GuestsSelectorState({
    this.adults = 0,
    this.children = 0,
    this.rooms = 0,
  });

  GuestsSelectorState copyWith({
    int? adults,
    int? children,
    int? rooms,
  }) {
    return GuestsSelectorState(
      adults: adults ?? this.adults,
      children: children ?? this.children,
      rooms: rooms ?? this.rooms,
    );
  }

  @override
  List<Object> get props => [adults, children, rooms];
}