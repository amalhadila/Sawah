class GetAllAcceptedToursResponse {
  String? status;
  TourData? data;

  GetAllAcceptedToursResponse({this.status, this.data});

  factory GetAllAcceptedToursResponse.fromJson(Map<String, dynamic> json) {
    return GetAllAcceptedToursResponse(
      status: json["status"] as String?,
      data: json["data"] != null ? TourData.fromJson(json["data"] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class TourData {
  List<Tour>? acceptedTours;

  TourData({this.acceptedTours});

  factory TourData.fromJson(Map<String, dynamic> json) {
    return TourData(
      acceptedTours: json["acceptedTours"] != null
          ? List<Tour>.from(json["acceptedTours"].map((x) => Tour.fromJson(x as Map<String, dynamic>)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "acceptedTours": acceptedTours != null ? List<dynamic>.from(acceptedTours!.map((x) => x.toJson())) : null,
      };
}

class Tour {
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
  bool? guideConfirmCompletion;
  bool? userConfirmCompletion;
  DateTime? createdAt;
  DateTime? updatedAt;
  Guide? acceptedGuide;
  int? price;
  List<dynamic>? sentRequests;
  List<dynamic>? respondingGuides;

  Tour({
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
    this.guideConfirmCompletion,
    this.userConfirmCompletion,
    this.createdAt,
    this.updatedAt,
    this.acceptedGuide,
    this.price,
    this.sentRequests,
    this.respondingGuides,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json["_id"] as String?,
      user: json["user"] != null ? User.fromJson(json["user"] as Map<String, dynamic>) : null,
      governorate: json["governorate"] as String?,
      spokenLanguages: json["spokenLanguages"] != null
          ? List<String>.from(json["spokenLanguages"].map((x) => x as String))
          : null,
      groupSize: json["groupSize"] as String?,
      landmarks: json["landmarks"] != null
          ? List<Landmark>.from(json["landmarks"].map((x) => Landmark.fromJson(x as Map<String, dynamic>)))
          : null,
      startDate: json["startDate"] != null ? DateTime.parse(json["startDate"] as String) : null,
      endDate: json["endDate"] != null ? DateTime.parse(json["endDate"] as String) : null,
      commentForGuide: json["commentForGuide"] as String?,
      status: json["status"] as String?,
      paymentStatus: json["paymentStatus"] as String?,
      guideConfirmCompletion: json["guideConfirmCompletion"] as bool?,
      userConfirmCompletion: json["userConfirmCompletion"] as bool?,
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"] as String) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"] as String) : null,
      acceptedGuide: json["acceptedGuide"] != null ? Guide.fromJson(json["acceptedGuide"] as Map<String, dynamic>) : null,
      price: json["price"] as int?,
      sentRequests: json["sentRequests"] != null
          ? List<dynamic>.from(json["sentRequests"].map((x) => x as dynamic))
          : null,
      respondingGuides: json["respondingGuides"] != null
          ? List<dynamic>.from(json["respondingGuides"].map((x) => x as dynamic))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "governorate": governorate,
        "spokenLanguages": spokenLanguages != null ? List<dynamic>.from(spokenLanguages!.map((x) => x)) : null,
        "groupSize": groupSize,
        "landmarks": landmarks != null ? List<dynamic>.from(landmarks!.map((x) => x.toJson())) : null,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "commentForGuide": commentForGuide,
        "status": status,
        "paymentStatus": paymentStatus,
        "guideConfirmCompletion": guideConfirmCompletion,
        "userConfirmCompletion": userConfirmCompletion,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "acceptedGuide": acceptedGuide?.toJson(),
        "price": price,
        "sentRequests": sentRequests != null ? List<dynamic>.from(sentRequests!.map((x) => x)) : null,
        "respondingGuides": respondingGuides != null ? List<dynamic>.from(respondingGuides!.map((x) => x)) : null,
      };
}

class User {
  String? id;
  String? name;
  String? photo;
  String? kind;

  User({this.id, this.name, this.photo, this.kind});

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
  List<String>? images;
  Category? category;

  Landmark({this.id, this.name, this.images, this.category});

  factory Landmark.fromJson(Map<String, dynamic> json) {
    return Landmark(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      images: json["images"] != null
          ? List<String>.from(json["images"].map((x) => x as String))
          : null,
      category: json["category"] != null ? Category.fromJson(json["category"] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images": images != null ? List<dynamic>.from(images!.map((x) => x)) : null,
        "category": category?.toJson(),
      };
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

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

class Guide {
  String? id;
  String? name;
  String? photo;
  String? kind;
  double? rating;
  int? ratingsQuantity;

  Guide({this.id, this.name, this.photo, this.kind, this.rating, this.ratingsQuantity});

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      photo: json["photo"] as String?,
      kind: json["kind"] as String?,
      rating: json["rating"] != null ? (json["rating"] as num).toDouble() : null,
      ratingsQuantity: json["ratingsQuantity"] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "photo": photo,
        "kind": kind,
        "rating": rating,
        "ratingsQuantity": ratingsQuantity,
      };
}
