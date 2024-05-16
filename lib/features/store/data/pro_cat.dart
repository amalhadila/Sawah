import 'package:equatable/equatable.dart';

class ProCat extends Equatable {
  final dynamic? id;
  final dynamic? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? slug;

  const ProCat({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.slug,
  });

  factory ProCat.fromJson(Map<String, dynamic> json) => ProCat(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        slug: json['slug'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'slug': slug,
      };

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt, slug];
}
