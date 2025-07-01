import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class StayDatesCubit extends Cubit<StayDatesState> {
  StayDatesCubit() : super(StayDatesInitial());

  void updateDates({DateTime? checkIn, DateTime? checkOut}) {
    if (checkIn == null && checkOut == null) {
      emit(StayDatesInitial());
      return;
    }

    if (state is StayDatesLoaded) {
      final currentState = state as StayDatesLoaded;
      final newCheckIn = checkIn ?? currentState.checkIn;
      final newCheckOut = checkOut ?? currentState.checkOut;

      if (newCheckIn != null && newCheckOut != null && newCheckIn.isBefore(newCheckOut)) {
        emit(StayDatesLoaded(checkIn: newCheckIn, checkOut: newCheckOut));
      } else if (newCheckIn != null || newCheckOut != null) {
        emit(StayDatesLoaded(checkIn: newCheckIn, checkOut: newCheckOut));
      } else {
        emit(StayDatesInitial());
      }
    } else {
      if (checkIn != null && checkOut != null && checkIn.isBefore(checkOut)) {
        emit(StayDatesLoaded(checkIn: checkIn, checkOut: checkOut));
      } else if (checkIn != null || checkOut != null) {
        emit(StayDatesLoaded(checkIn: checkIn, checkOut: checkOut));
      }
    }
  }

  void clearDates() {
    emit(StayDatesInitial());
  }
}

abstract class StayDatesState extends Equatable {
  const StayDatesState();

  @override
  List<Object?> get props => [];
}

class StayDatesInitial extends StayDatesState {}

class StayDatesLoaded extends StayDatesState {
  final DateTime? checkIn;
  final DateTime? checkOut;

  const StayDatesLoaded({this.checkIn, this.checkOut});

  StayDatesLoaded copyWith({DateTime? checkIn, DateTime? checkOut}) {
    return StayDatesLoaded(
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
    );
  }

  @override
  List<Object?> get props => [checkIn, checkOut];
}