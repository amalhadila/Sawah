import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String? type;
  final List<dynamic>? coordinates;
  final String? address;
  final String? description;
  final int? day;
  final String? id;

  const Location({
    this.type,
    this.coordinates,
    this.address,
    this.description,
    this.day,
    this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json['type'] as String?,
        coordinates: json['coordinates'] as List<dynamic>?,
        address: json['address'] as String?,
        description: json['description'] as String?,
        day: json['day'] as int?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
        'address': address,
        'description': description,
        'day': day,
        '_id': id,
        'id': id,
      };

  @override
  List<Object?> get props {
    return [
      type,
      coordinates,
      address,
      description,
      day,
      id,
      id,
    ];
  }
}
