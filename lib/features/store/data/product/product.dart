import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'guide.dart';
import 'location.dart';

class Product extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final int? duration;
  final List<dynamic> images;
  final List<Location>? locations;
  final int? price;
  final int? maxGroupSize;
  final List<dynamic>? startDays;
  final Guide? guide; // تم استبدال List<Guide> بـ Guide والتأكد من التطابق مع JSON
  final dynamic rating;
  final int? ratingsQuantity;
  final int? bookings;
  final String? slug;
  final dynamic? category;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    this.id,
    this.name,
    this.description,
     this.duration,
    required this.images,
    this.locations,
    this.price,
    this.maxGroupSize,
    this.startDays,
    this.guide,
    this.rating,
    this.ratingsQuantity,
    this.bookings,
    this.slug,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as int?,
      images: (json['images'] as List<dynamic>).cast<String>(),
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json['price'] as int?,
      maxGroupSize: json['maxGroupSize'] as int?,
      startDays: (json['startDays'] as List<dynamic>?)?.cast<String>(),
      guide: json['guide'] != null ? Guide.fromJson(json['guide'] as Map<String, dynamic>) : null,
      rating: json['rating'] as dynamic,
      ratingsQuantity: json['ratingsQuantity'] as int?,
      bookings: json['bookings'] as int?,
      slug: json['slug'] as String?,
      category: json['category'],
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'images': images,
      'locations': locations?.map((e) => e.toJson()).toList(),
      'price': price,
      'maxGroupSize': maxGroupSize,
      'startDays': startDays,
      'guide': guide?.toJson(), // تحويل Guide إلى JSON
      'rating': rating,
      'ratingsQuantity': ratingsQuantity,
      'bookings': bookings,
      'slug': slug,
      'category': category,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    duration,
    images,
    locations,
    price,
    maxGroupSize,
    startDays,
    guide,
    rating,
    ratingsQuantity,
    bookings,
    slug,
    category,
    createdAt,
    updatedAt,
  ];
}
