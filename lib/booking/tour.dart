import 'package:equatable/equatable.dart';

import 'guide.dart';
import 'tour.dart';

class Tour extends Equatable {
  final Tour? tour;
  final int? groupSize;
  final int? price;
  final DateTime? tourDate;
  final Guide? guide;
  final String? id;

  const Tour({
    this.tour,
    this.groupSize,
    this.price,
    this.tourDate,
    this.guide,
    this.id,
  });

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        tour: json['tour'] == null
            ? null
            : Tour.fromJson(json['tour'] as Map<String, dynamic>),
        groupSize: json['groupSize'] as int?,
        price: json['price'] as int?,
        tourDate: json['tourDate'] == null
            ? null
            : DateTime.parse(json['tourDate'] as String),
        guide: json['guide'] == null
            ? null
            : Guide.fromJson(json['guide'] as Map<String, dynamic>),
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'tour': tour?.toJson(),
        'groupSize': groupSize,
        'price': price,
        'tourDate': tourDate?.toIso8601String(),
        'guide': guide?.toJson(),
        '_id': id,
      };

  @override
  List<Object?> get props {
    return [
      tour,
      groupSize,
      price,
      tourDate,
      guide,
      id,
    ];
  }
}
