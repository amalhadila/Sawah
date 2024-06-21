class ReviewModel {
  final String status;
  final ReviewData data;

  ReviewModel({
    required this.status,
    required this.data,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewModel(
      status: jsonData['status'],
      data: ReviewData.fromJson(jsonData['data']['doc']),
    );
  }
}

class ReviewData {
  final String user;
  final String reviewType;
  final String subject;
  final double rating;
  final String comment;
  final String id;
  final String createdAt;

  ReviewData({
    required this.user,
    required this.reviewType,
    required this.subject,
    required this.rating,
    required this.comment,
    required this.id,
    required this.createdAt,
  });

  factory ReviewData.fromJson(Map<String, dynamic> jsonData) {
    return ReviewData(
      user: jsonData['user'],
      reviewType: jsonData['reviewType'],
      subject: jsonData['subject'],
      rating: jsonData['rating'].toDouble(),
      comment: jsonData['comment'],
      id: jsonData['_id'],
      createdAt: jsonData['createdAt'],
    );
  }
}