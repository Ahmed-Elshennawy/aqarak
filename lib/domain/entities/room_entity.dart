class RoomEntity {
  final String id;
  final String name;
  final String location;
  final String type;
  final String airConditioned;

  RoomEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.airConditioned,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'type': type,
    'airConditioned': airConditioned,
  };

  factory RoomEntity.fromJson(Map<String, dynamic> json) => RoomEntity(
    id: json['id'],
    name: json['name'],
    location: json['name'],
    type: json['type'],
    airConditioned: json['airConditioned'],
  );
}
