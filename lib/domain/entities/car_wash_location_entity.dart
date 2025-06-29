class CarWashLocationEntity {
  final String id;
  final String name;
  final String location;

  CarWashLocationEntity({
    required this.id,
    required this.name,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
  };

  factory CarWashLocationEntity.fromJson(Map<String, dynamic> json) =>
      CarWashLocationEntity(
        id: json['id'],
        name: json['name'],
        location: json['location'],
      );
}
