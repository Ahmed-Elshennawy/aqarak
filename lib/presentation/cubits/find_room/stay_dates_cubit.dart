import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class StayDatesCubit extends Cubit<StayDatesState> {
  StayDatesCubit() : super(StayDatesInitial());

  void updateCheckIn(DateTime dateTime) {
    if (state is StayDatesLoaded) {
      emit((state as StayDatesLoaded).copyWith(checkIn: dateTime));
    } else {
      emit(StayDatesLoaded(checkIn: dateTime, checkOut: null));
    }
  }

  void updateCheckOut(DateTime dateTime) {
    if (state is StayDatesLoaded) {
      emit((state as StayDatesLoaded).copyWith(checkOut: dateTime));
    } else {
      emit(StayDatesLoaded(checkIn: null, checkOut: dateTime));
    }
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
