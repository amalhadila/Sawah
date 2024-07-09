class GetMyRequestTourByIdModel {
  String status;
  Data data;

  GetMyRequestTourByIdModel({
    required this.status,
    required this.data,
  });

  factory GetMyRequestTourByIdModel.fromJson(Map<String, dynamic> json) => GetMyRequestTourByIdModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Request request;

  Data({
    required this.request,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        request: Request.fromJson(json["request"]),
      );

  Map<String, dynamic> toJson() => {
        "request": request.toJson(),
      };
}

class Request {
  String id;
  User user;
  String governorate;
  List<String> spokenLanguages;
  String groupSize;
  List<Landmark> landmarks;
  DateTime startDate;
  DateTime endDate;
  String commentForGuide;
  String status;
  String paymentStatus;
  List<dynamic> sentRequests;
  List<dynamic> respondingGuides;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Request({
    required this.id,
    required this.user,
    required this.governorate,
    required this.spokenLanguages,
    required this.groupSize,
    required this.landmarks,
    required this.startDate,
    required this.endDate,
    required this.commentForGuide,
    required this.status,
    required this.paymentStatus,
    required this.sentRequests,
    required this.respondingGuides,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        governorate: json["governorate"],
        spokenLanguages: List<String>.from(json["spokenLanguages"].map((x) => x)),
        groupSize: json["groupSize"],
        landmarks: List<Landmark>.from(json["landmarks"].map((x) => Landmark.fromJson(x))),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        commentForGuide: json["commentForGuide"],
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        sentRequests: List<dynamic>.from(json["sentRequests"].map((x) => x)),
        respondingGuides: List<dynamic>.from(json["respondingGuides"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
        "governorate": governorate,
        "spokenLanguages": List<dynamic>.from(spokenLanguages.map((x) => x)),
        "groupSize": groupSize,
        "landmarks": List<dynamic>.from(landmarks.map((x) => x.toJson())),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "commentForGuide": commentForGuide,
        "status": status,
        "paymentStatus": paymentStatus,
        "sentRequests": List<dynamic>.from(sentRequests.map((x) => x)),
        "respondingGuides": List<dynamic>.from(respondingGuides.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class User {
  String id;
  String name;
  String photo;
  String kind;

  User({
    required this.id,
    required this.name,
    required this.photo,
    required this.kind,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        photo: json["photo"],
        kind: json["kind"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "photo": photo,
        "kind": kind,
      };
}

class Landmark {
  String id;
  String name;
  Category category;

  Landmark({
    required this.id,
    required this.name,
    required this.category,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) => Landmark(
        id: json["_id"],
        name: json["name"],
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category": category.toJson(),
      };
}

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
