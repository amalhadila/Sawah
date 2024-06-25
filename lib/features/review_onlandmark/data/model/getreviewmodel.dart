class Getreviewmodel {
  final String status;
  final String requestedAt;
  final int results;
  final String id;

  final String reviewType;
  final String subject;
  final double rating;
  final String comment;
  final String createdAt;
  final String iduser;
  final String name;
  final String photo;
  final String kind;

  Getreviewmodel({
    required this.id,
    required this.reviewType,
    required this.subject,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.iduser,
    required this.name,
    required this.photo,
    required this.kind,
    required this.status,
    required this.requestedAt,
    required this.results,
  });

  factory Getreviewmodel.fromJson(Map<String, dynamic> jsonData) {
    return Getreviewmodel(
      status: jsonData['status'],
      requestedAt: jsonData['requestedAt'],
      results: jsonData['results'],
      id: jsonData['_id'],
      reviewType: jsonData['data']['docs']['Landmark'],
      subject: jsonData['subject'],
      comment: jsonData['comment'],
      rating: (jsonData['rating'] as num).toDouble(),
      createdAt: jsonData['createdAt'],
      iduser: jsonData['user']['user'],
      name: jsonData['user']['name'],
      photo: jsonData['user']['photo'],
      kind: jsonData['user']['kind'],
    );
  }
}
