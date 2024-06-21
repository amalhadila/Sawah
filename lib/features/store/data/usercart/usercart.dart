import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class Usercart extends Equatable {
  final String? id;
  final List<CartItem>? cartItems;
  final String? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? totalCartPrice;

  const Usercart({
    this.id,
    this.cartItems,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });

  factory Usercart.fromJson(Map<String, dynamic> json) => Usercart(
        id: json['_id'] as String?,
        cartItems: (json['cartItems'] as List<dynamic>?)
            ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        user: json['user'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        totalCartPrice: json['totalCartPrice'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'cartItems': cartItems?.map((e) => e.toJson()).toList(),
        'user': user,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'totalCartPrice': totalCartPrice,
      };

  @override
  List<Object?> get props {
    return [
      id,
      cartItems,
      user,
      createdAt,
      updatedAt,
      v,
      totalCartPrice,
    ];
  }
}
