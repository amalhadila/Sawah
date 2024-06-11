import 'package:equatable/equatable.dart';

class Wishlistitem extends Equatable {
  final String? id;
  final String? name;
  final List<dynamic>? images;
  final int? price;

  const Wishlistitem({
    this.id,
    this.name,
    this.images,
    this.price,
  });

  factory Wishlistitem.fromJson(Map<String, dynamic> json) => Wishlistitem(
        name: json['name'] as String?,
        images: json['images'] as List<dynamic>?,
        price: json['price'] as int?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'images': images,
        'price': price,
        'id': id,
      };

  @override
  List<Object?> get props => [id, name, images, price, id];
}
