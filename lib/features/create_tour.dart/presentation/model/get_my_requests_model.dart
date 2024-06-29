class GetMyRequestsModel {
  final String? id;
  final User? user;
  final String? governorate;
  final List<String>? spokenLanguages;
  final String? groupSize;
  final List<Landmark>? landmarks;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? commentForGuide;
  final String? status;
  final String? paymentStatus;
  final List<dynamic>? sentRequests;
  final List<dynamic>? respondingGuides;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  GetMyRequestsModel({
    this.id,
    this.user,
    this.governorate,
    this.spokenLanguages,
    this.groupSize,
    this.landmarks,
    this.startDate,
    this.endDate,
    this.commentForGuide,
    this.status,
    this.paymentStatus,
    this.sentRequests,
    this.respondingGuides,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetMyRequestsModel.fromJson(Map<String, dynamic> json) {
    return GetMyRequestsModel(
      id: json['_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      governorate: json['governorate'],
      spokenLanguages: json['spokenLanguages'] != null
          ? List<String>.from(json['spokenLanguages'])
          : null,
      groupSize: json['groupSize'],
      landmarks: json['landmarks'] != null
          ? List<Landmark>.from(
              json['landmarks'].map((x) => Landmark.fromJson(x)))
          : null,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      commentForGuide: json['commentForGuide'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      sentRequests: json['sentRequests'],
      respondingGuides: json['respondingGuides'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      v: json['__v'],
    );
  }
}

class User {
  final String? id;
  final String? name;
  final String? photo;
  final String? kind;

  User({
    required this.id,
    required this.name,
    required this.photo,
    required this.kind,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      photo: json['photo'],
      kind: json['kind'],
    );
  }
}

class Landmark {
  final String? id;
  final String? name;
  final Category? category;

  Landmark({
    required this.id,
    required this.name,
    required this.category,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      id: json['_id'],
      name: json['name'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
    );
  }
}

class Category {
  final String? id;
  final String? name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }
}