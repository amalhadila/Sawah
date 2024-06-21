import 'package:equatable/equatable.dart';

import 'category.dart';
import 'location.dart';

class MostVisitedModel extends Equatable {
  final Location? location;
  final String? idcat;
  final String? name;
  final String? description;
  final String? imageCover;
  final List<String>? images; // Updated to List<String> to match the JSON response
  final Category? category;
  final int? visitsNumber;
  final double? rating;
  final int? ratingsQuantity;
  final String? slug;
  final int? v;
  final String? id;

  const MostVisitedModel({
    this.location,
    this.idcat,
    this.name,
    this.description,
    this.imageCover,
    this.images,
    this.category,
    this.visitsNumber,
    this.rating,
    this.ratingsQuantity,
    this.slug,
    this.v,
    this.id,
  });

  factory MostVisitedModel.fromJson(Map<String, dynamic> json) {
    return MostVisitedModel(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      idcat: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageCover: json['imageCover'] as String?,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      visitsNumber: json['visitsNumber'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
      ratingsQuantity: json['ratingsQuantity'] as int?,
      slug: json['slug'] as String?,
      v: json['__v'] as int?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        '_id': idcat,
        'name': name,
        'description': description,
        'imageCover': imageCover,
        'images': images,
        'category': category?.toJson(),
        'visitsNumber': visitsNumber,
        'rating': rating,
        'ratingsQuantity': ratingsQuantity,
        'slug': slug,
        '__v': v,
        'id': id,
      };

  @override
  List<Object?> get props {
    return [
      location,
      idcat,
      name,
      description,
      imageCover,
      images,
      category,
      visitsNumber,
      rating,
      ratingsQuantity,
      slug,
      v,
      id,
    ];
  }
}
