import 'user.dart';

class GetReviewModel {
  String? id;
  User? user;
  String? reviewType;
  String? subject;
  double? rating; // استخدام النوع الصحيح
  String? comment;
  DateTime? createdAt;

  GetReviewModel({
    this.id,
    this.user,
    this.reviewType,
    this.subject,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory GetReviewModel.fromJson(Map<String, dynamic> json) {
    return GetReviewModel(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      reviewType: json['reviewType'] as String?,
      subject: json['subject'] as String?,
      rating: json['rating'] == null
          ? null
          : (json['rating'] as num).toDouble(), // التعامل مع null بشكل صحيح
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user?.toJson(),
        'reviewType': reviewType,
        'subject': subject,
        'rating': rating,
        'comment': comment,
        'createdAt': createdAt?.toIso8601String(),
      };
}
