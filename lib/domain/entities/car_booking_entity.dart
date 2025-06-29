class CarBookingEntity {
  final String id;
  final String pickupLocation;
  final String dropoffLocation;
  final String carType;

  CarBookingEntity({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.carType,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'pickupLocation': pickupLocation,
    'dropoffLocation': dropoffLocation,
    'carType': carType,
  };

  factory CarBookingEntity.fromJson(Map<String, dynamic> json) =>
      CarBookingEntity(
        id: json['id'],
        pickupLocation: json['pickupLocation'],
        dropoffLocation: json['dropoffLocation'],
        carType: json['carType'],
      );
}
