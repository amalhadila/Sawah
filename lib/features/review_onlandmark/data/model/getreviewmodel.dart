class Getreviewmodel {
  final String status;
  final String requestedAt;
  final int results;
  final List<ReviewData> data;

  Getreviewmodel({
    required this.status,
    required this.requestedAt,
    required this.results,
    required this.data,
  });

  factory Getreviewmodel.fromJson(Map<String, dynamic> jsonData) {
    var list = jsonData['data']['docs'] as List;
    List<ReviewData> reviewList = list.map((i) => ReviewData.fromJson(i)).toList();

    return Getreviewmodel(
      status: jsonData['status'],
      requestedAt: jsonData['requestedAt'],
      results: jsonData['results'],
      data: reviewList,
    );
  }
}

class ReviewData {
  final String id;
  final User user;
  final String reviewType;
  final String subject;
  final double rating;
  final String comment;
  final String createdAt;

  ReviewData({
    required this.id,
    required this.user,
    required this.reviewType,
    required this.subject,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory ReviewData.fromJson(Map<String, dynamic> jsonData) {
    return ReviewData(
      id: jsonData['_id'],
      user: User.fromJson(jsonData['user']),
      reviewType: jsonData['reviewType'],
      subject: jsonData['subject'],
      rating: (jsonData['rating'] as num).toDouble(),
      comment: jsonData['comment'],
      createdAt: jsonData['createdAt'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String photo;
  final String kind;

  User({
    required this.id,
    required this.name,
    required this.photo,
    required this.kind,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['_id'],
      name: jsonData['name'],
      photo: jsonData['photo'],
      kind: jsonData['kind'],
    );
  }
}
