class RoomEntity {
  final String id;
  final String name;
  final String location;
  final String type; // e.g., Hotel, Villa
  final bool airConditioned;
  final String imageUrl;

  RoomEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.airConditioned,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'type': type,
    'airConditioned': airConditioned,
    'imageUrl': imageUrl,
  };

  factory RoomEntity.fromJson(Map<String, dynamic> json) => RoomEntity(
    id: json['id'],
    name: json['name'],
    location: json['location'],
    type: json['type'],
    airConditioned: json['airConditioned'],
    imageUrl: json['imageUrl'],
  );
}
