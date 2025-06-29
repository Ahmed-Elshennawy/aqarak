part of 'book_car_cubit.dart';

sealed class BookCarState extends Equatable {
  const BookCarState();

  @override
  List<Object> get props => [];
}

final class BookCarInitial extends BookCarState {}

final class BookCarLoading extends BookCarState {}

class BookCarLoaded extends BookCarState {
  final List<CarBookingEntity> carBookings;
  const BookCarLoaded(this.carBookings);
}

class BookCarError extends BookCarState {
  final String message;
  const BookCarError(this.message);
}
