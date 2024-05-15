import 'package:equatable/equatable.dart';

import 'brand.dart';
import 'category.dart';
import 'sub_category.dart';

class Products extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final dynamic? price;
  final dynamic? discount;
  final dynamic? priceAfterDiscount;
  final int? quantity;
  final int? sold;
  final Category? category;
  final Brand? brand;
  final SubCategory? subCategory;
  final List<dynamic>? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;

  const Products({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.quantity,
    this.sold,
    this.category,
    this.brand,
    this.subCategory,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.slug,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        price: json['price'] as dynamic?,
        discount: json['discount'] as dynamic?,
        priceAfterDiscount: json['priceAfterDiscount'] as dynamic?,
        quantity: json['quantity'] as int?,
        sold: json['sold'] as int?,
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
        brand: json['brand'] == null
            ? null
            : Brand.fromJson(json['brand'] as Map<String, dynamic>),
        subCategory: json['subCategory'] == null
            ? null
            : SubCategory.fromJson(json['subCategory'] as Map<String, dynamic>),
        images: json['images'] as List<dynamic>?,
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
        'description': description,
        'price': price,
        'discount': discount,
        'priceAfterDiscount': priceAfterDiscount,
        'quantity': quantity,
        'sold': sold,
        'category': category?.toJson(),
        'brand': brand?.toJson(),
        'subCategory': subCategory?.toJson(),
        'images': images,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'slug': slug,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
      price,
      discount,
      priceAfterDiscount,
      quantity,
      sold,
      category,
      brand,
      subCategory,
      images,
      createdAt,
      updatedAt,
      slug,
    ];
  }
}
