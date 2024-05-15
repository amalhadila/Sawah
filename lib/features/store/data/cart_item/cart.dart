import 'package:equatable/equatable.dart';

import 'cart_item.dart';

class Cart extends Equatable {
  final String? id;
  final List<CartItem>? cartItems;
  final String? user;
  final bool? couponed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? totalCartPrice;
  final double? totalPriceAfterDiscount;

  const Cart({
    this.id,
    this.cartItems,
    this.user,
    this.couponed,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
    this.totalPriceAfterDiscount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['_id'] as String?,
        cartItems: (json['cartItems'] as List<dynamic>?)
            ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        user: json['user'] as String?,
        couponed: json['couponed'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        totalCartPrice: json['totalCartPrice'] as int?,
        totalPriceAfterDiscount:
            (json['totalPriceAfterDiscount'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'cartItems': cartItems?.map((e) => e.toJson()).toList(),
        'user': user,
        'couponed': couponed,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'totalCartPrice': totalCartPrice,
        'totalPriceAfterDiscount': totalPriceAfterDiscount,
      };

  @override
  List<Object?> get props {
    return [
      id,
      cartItems,
      user,
      couponed,
      createdAt,
      updatedAt,
      v,
      totalCartPrice,
      totalPriceAfterDiscount,
    ];
  }
}
