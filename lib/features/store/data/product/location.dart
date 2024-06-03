import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String? type;
  final List<dynamic>? coordinates;
  final String? description;
  final int? day;
  final String? iid;
  final String? id;

  const Location({
    this.type,
    this.coordinates,
    this.description,
    this.day,
    this.iid,
    this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json['type'] as String?,
        coordinates: json['coordinates'] as List<dynamic>?,
        description: json['description'] as String?,
        day: json['day'] as int?,
        iid: json['_id'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
        'description': description,
        'day': day,
        '_id': iid,
        'id': id,
      };

  @override
  List<Object?> get props {
    return [
      type,
      coordinates,
      description,
      day,
      iid,
      id,
    ];
  }
}
