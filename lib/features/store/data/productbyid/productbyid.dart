import 'package:equatable/equatable.dart';

import 'guide.dart';
import 'location.dart';

class Productbyid extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final int? duration;
  final List<dynamic>? images;
  final List<Location>? locations;
  final int? price;
  final int? maxGroupSize;
  final List<dynamic>? startDays;
  final List<Guide>? guides;
  final double? rating;
  final int? ratingsQuantity;
  final int? bookings;
  final String? slug;
  final dynamic? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const Productbyid({
    this.id,
    this.name,
    this.description,
    this.duration,
    this.images,
    this.locations,
    this.price,
    this.maxGroupSize,
    this.startDays,
    this.guides,
    this.rating,
    this.ratingsQuantity,
    this.bookings,
    this.slug,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Productbyid.fromJson(Map<String, dynamic> json) => Productbyid(
        name: json['name'] as String?,
        description: json['description'] as String?,
        duration: json['duration'] as int?,
        images: json['images'] as List<dynamic>?,
        locations: (json['locations'] as List<dynamic>?)
            ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
            .toList(),
        price: json['price'] as int?,
        maxGroupSize: json['maxGroupSize'] as int?,
        startDays: json['startDays'] as List<dynamic>?,
        guides: (json['guides'] as List<dynamic>?)
            ?.map((e) => Guide.fromJson(e as Map<String, dynamic>))
            .toList(),
        rating: (json['rating'] as num?)?.toDouble(),
        ratingsQuantity: json['ratingsQuantity'] as int?,
        bookings: json['bookings'] as int?,
        slug: json['slug'] as String?,
        category: json['category'] as dynamic?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'duration': duration,
        'images': images,
        'locations': locations?.map((e) => e.toJson()).toList(),
        'price': price,
        'maxGroupSize': maxGroupSize,
        'startDays': startDays,
        'guides': guides?.map((e) => e.toJson()).toList(),
        'rating': rating,
        'ratingsQuantity': ratingsQuantity,
        'bookings': bookings,
        'slug': slug,
        'category': category,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'id': id,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      duration,
      images,
      locations,
      price,
      maxGroupSize,
      startDays,
      guides,
      rating,
      ratingsQuantity,
      bookings,
      slug,
      category,
      createdAt,
      updatedAt,
      v,
      id,
    ];
  }
}
