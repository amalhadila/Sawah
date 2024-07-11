class GetAllAcceptedToursResponse {
  String? status;
  TourData? data;

  GetAllAcceptedToursResponse({this.status, this.data});

  factory GetAllAcceptedToursResponse.fromJson(Map<String, dynamic> json) {
    return GetAllAcceptedToursResponse(
      status: json["status"] as String?,
      data: json["data"] != null
          ? TourData.fromJson(json["data"] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class TourData {
  List<Tour>? activeTours;
  List<Tour>? completedTours;

  TourData({this.activeTours, this.completedTours});

  factory TourData.fromJson(Map<String, dynamic> json) {
    return TourData(
      activeTours: json["activeTours"] != null
          ? List<Tour>.from(json["activeTours"]
              .map((x) => Tour.fromJson(x as Map<String, dynamic>)))
          : null,
      completedTours: json["completedTours"] != null
          ? List<Tour>.from(json["completedTours"]
              .map((x) => Tour.fromJson(x as Map<String, dynamic>)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "activeTours": activeTours != null
            ? List<dynamic>.from(activeTours!.map((x) => x.toJson()))
            : null,
        "completedTours": completedTours != null
            ? List<dynamic>.from(completedTours!.map((x) => x.toJson()))
            : null,
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
  List<dynamic>? sentRequests;
  List<dynamic>? respondingGuides;
  DateTime? createdAt;
  DateTime? updatedAt;
  Guide? acceptedGuide;
  int? price;

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
    this.sentRequests,
    this.respondingGuides,
    this.createdAt,
    this.updatedAt,
    this.acceptedGuide,
    this.price,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
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
      acceptedGuide: json["acceptedGuide"] != null
          ? Guide.fromJson(json["acceptedGuide"] as Map<String, dynamic>)
          : null,
      price: json["price"] as int?,
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
        "acceptedGuide": acceptedGuide?.toJson(),
        "price": price,
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
      category: json["category"] != null
          ? Category.fromJson(json["category"] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images":
            images != null ? List<dynamic>.from(images!.map((x) => x)) : null,
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

  Guide(
      {this.id,
      this.name,
      this.photo,
      this.kind,
      this.rating,
      this.ratingsQuantity});

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      photo: json["photo"] as String?,
      kind: json["kind"] as String?,
      rating:
          json["rating"] != null ? (json["rating"] as num).toDouble() : null,
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
