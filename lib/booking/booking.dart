import 'package:equatable/equatable.dart';

import 'tour.dart';
import 'user.dart';

class Booking extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final User? user;
  final List<Tour>? tours;
  final String? tourType;
  final String? status;
  final int? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Booking({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.user,
    this.tours,
    this.tourType,
    this.status,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['_id'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        phone: json['phone'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        tours: (json['tours'] as List<dynamic>?)
            ?.map((e) => Tour.fromJson(e as Map<String, dynamic>))
            .toList(),
        tourType: json['tourType'] as String?,
        status: json['status'] as String?,
        totalPrice: json['totalPrice'] as int?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'user': user?.toJson(),
        'tours': tours?.map((e) => e.toJson()).toList(),
        'tourType': tourType,
        'status': status,
        'totalPrice': totalPrice,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      phone,
      user,
      tours,
      tourType,
      status,
      totalPrice,
      createdAt,
      updatedAt,
    ];
  }
}
