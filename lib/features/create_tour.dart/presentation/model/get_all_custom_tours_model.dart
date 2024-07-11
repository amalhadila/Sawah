class GetAllCustomToursModel {
  String? id;
  User? user;
  String? governorate;
  List<String>? spokenLanguages;
  String? groupSize;
  List<Landmark>? landmarks;
  DateTime? startDate;
  DateTime? endDate;
  String? commentForGuide;
  String? status;
  String? paymentStatus;
  List<dynamic>? sentRequests;
  List<dynamic>? respondingGuides;
  DateTime? createdAt;
  DateTime? updatedAt;

  GetAllCustomToursModel({
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
  });

  factory GetAllCustomToursModel.fromJson(Map<String, dynamic> json) {
    return GetAllCustomToursModel(
      id: json["_id"] as String?,
      user: json["user"] != null
          ? User.fromJson(json["user"] as Map<String, dynamic>)
          : null,
      governorate: json["governorate"] as String?,
      spokenLanguages: json["spokenLanguages"] != null
          ? List<String>.from(json["spokenLanguages"].map((x) => x as String))
          : null,
      groupSize: json["groupSize"] as String?,
      landmarks: json["landmarks"] != null
          ? List<Landmark>.from(json["landmarks"]
              .map((x) => Landmark.fromJson(x as Map<String, dynamic>)))
          : null,
      startDate: json["startDate"] != null
          ? DateTime.parse(json["startDate"] as String)
          : null,
      endDate: json["endDate"] != null
          ? DateTime.parse(json["endDate"] as String)
          : null,
      commentForGuide: json["commentForGuide"] as String?,
      status: json["status"] as String?,
      paymentStatus: json["paymentStatus"] as String?,
      sentRequests: json["sentRequests"] != null
          ? List<dynamic>.from(json["sentRequests"].map((x) => x as dynamic))
          : null,
      respondingGuides: json["respondingGuides"] != null
          ? List<dynamic>.from(
              json["respondingGuides"].map((x) => x as dynamic))
          : null,
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"] as String)
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "governorate": governorate,
        "spokenLanguages": spokenLanguages != null
            ? List<dynamic>.from(spokenLanguages!.map((x) => x))
            : null,
        "groupSize": groupSize,
        "landmarks": landmarks != null
            ? List<dynamic>.from(landmarks!.map((x) => x.toJson()))
            : null,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "commentForGuide": commentForGuide,
        "status": status,
        "paymentStatus": paymentStatus,
        "sentRequests": sentRequests != null
            ? List<dynamic>.from(sentRequests!.map((x) => x))
            : null,
        "respondingGuides": respondingGuides != null
            ? List<dynamic>.from(respondingGuides!.map((x) => x))
            : null,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class User {
  String? id;
  String? name;
  String? photo;
  String? kind;

  User({
    this.id,
    this.name,
    this.photo,
    this.kind,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      photo: json["photo"] as String?,
      kind: json["kind"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "photo": photo,
        "kind": kind,
      };
}

class Landmark {
  String? id;
  String? name;
  Category? category;

  Landmark({
    this.id,
    this.name,
    this.category,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      category: json["category"] != null
          ? Category.fromJson(json["category"] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category": category?.toJson(),
      };
}

class Category {
  String? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["_id"] as String?,
      name: json["name"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
