import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String? name;
  final int? price;
  final int? discount;
  final double? priceAfterDiscount;
  final int? quantity;
  final List<dynamic>? images;

  const Product({
    this.id,
    this.name,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.quantity,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        discount: json['discount'] as int?,
        priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toDouble(),
        quantity: json['quantity'] as int?,
        images: json['images'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'price': price,
        'discount': discount,
        'priceAfterDiscount': priceAfterDiscount,
        'quantity': quantity,
        'images': images,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      price,
      discount,
      priceAfterDiscount,
      quantity,
      images,
    ];
  }
}
