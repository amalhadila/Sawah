import 'package:equatable/equatable.dart';

import 'cart.dart';

class CartItem extends Equatable {
  final Cart? cart;

  const CartItem({this.cart});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cart: json['cart'] == null
            ? null
            : Cart.fromJson(json['cart'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'cart': cart?.toJson(),
      };

  @override
  List<Object?> get props => [cart];
}
