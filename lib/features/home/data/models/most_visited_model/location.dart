import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String? type;
  final List<dynamic>? coordinates;
  final String? governorate;

  const Location({this.type, this.coordinates, this.governorate});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json['type'] as String?,
        coordinates: json['coordinates'] as List<dynamic>?,
        governorate: json['governorate'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
        'governorate': governorate,
      };

  @override
  List<Object?> get props => [type, coordinates, governorate];
}
