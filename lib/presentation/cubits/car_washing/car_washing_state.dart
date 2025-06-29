part of 'car_washing_cubit.dart';

sealed class CarWashingState extends Equatable {
  const CarWashingState();

  @override
  List<Object> get props => [];
}

class CarWashingInitial extends CarWashingState {}

class CarWashingLoading extends CarWashingState {}

class CarWashingLoaded extends CarWashingState {
  final List<CarWashLocationEntity> locations;
  const CarWashingLoaded(this.locations);
}

class CarWashingError extends CarWashingState {
  final String message;
  const CarWashingError(this.message);
}
