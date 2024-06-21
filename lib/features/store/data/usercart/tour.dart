import 'package:equatable/equatable.dart';

class Tour extends Equatable {
  final String? id;
  final String? name;
  final int? duration;
  final List<dynamic>? images;
  final int? price;
  final List<dynamic>? guides;

  const Tour({
    this.id,
    this.name,
    this.duration,
    this.images,
    this.price,
    this.guides,
  });

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        duration: json['duration'] as int?,
        images: json['images'] as List<dynamic>?,
        price: json['price'] as int?,
        guides: json['guides'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'duration': duration,
        'images': images,
        'price': price,
        'guides': guides,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      duration,
      images,
      price,
      guides,
    ];
  }
}
