import 'package:equatable/equatable.dart';

class tour extends Equatable {
  final String id;
  final String name;
  final int duration;
  final List<String> images;
  final int price;
  final int groupSize;
  final DateTime tourDate;
  final String guideName;
  final String guideEmail;

  tour({
    this.id = '',
    this.name = '',
    this.duration = 0,
    this.images = const [],
    this.price = 0,
    DateTime? tourDate,
    this.guideName = '',
    this.guideEmail = '',
    this.groupSize = 0,
  }) : tourDate = tourDate ?? DateTime.now();

  @override
  List<Object> get props => [
        id,
        name,
        duration,
        images,
        price,
        tourDate,
        guideName,
        guideEmail,
        groupSize
      ];

  factory tour.fromJson(Map<String, dynamic> json) {
    return tour(
      groupSize: json['groupSize'] ?? 0,
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      duration: json['duration'] ?? 0,
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      price: json['price'] ?? 0,
      tourDate: json['tourDate'] != null
          ? DateTime.parse(json['tourDate'])
          : DateTime.now(),
      guideName: json['guide'] != null ? json['guide']['name'] ?? '' : '',
      guideEmail: json['guide'] != null ? json['guide']['email'] ?? '' : '',
    );
  }
}
