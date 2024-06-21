import 'package:equatable/equatable.dart';

import 'tour.dart';

class CartItem extends Equatable {
  final Tour? tour;
  final int? groupSize;
  final int? itemPrice;
  final DateTime? tourDate;
  final String? id;

  const CartItem({
    this.tour,
    this.groupSize,
    this.itemPrice,
    this.tourDate,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        tour: json['tour'] == null
            ? null
            : Tour.fromJson(json['tour'] as Map<String, dynamic>),
        groupSize: json['groupSize'] as int?,
        itemPrice: json['itemPrice'] as int?,
        tourDate: json['tourDate'] == null
            ? null
            : DateTime.parse(json['tourDate'] as String),
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'tour': tour?.toJson(),
        'groupSize': groupSize,
        'itemPrice': itemPrice,
        'tourDate': tourDate?.toIso8601String(),
        '_id': id,
      };

  @override
  List<Object?> get props => [tour, groupSize, itemPrice, tourDate, id];
}
