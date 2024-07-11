class ResetPasswordModel {
  String status;
  String token;
  Data data;

  ResetPasswordModel({
    required this.status,
    required this.token,
    required this.data,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModel(
        status: json["status"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "data": data.toJson(),
      };
}

class Data {
  User user;

  Data({
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  String id;
  String name;
  String email;
  String photo;
  String role;
  bool emailVerified;
  String kind;
  List<dynamic> languages;
  List<dynamic> governorates;
  List<dynamic> gallery;
  bool isVerified;
  int rating;
  int ratingsQuantity;
  List<dynamic> tourRequests;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  DateTime passwordChangedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.emailVerified,
    required this.kind,
    required this.languages,
    required this.governorates,
    required this.gallery,
    required this.isVerified,
    required this.rating,
    required this.ratingsQuantity,
    required this.tourRequests,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.passwordChangedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
        role: json["role"],
        emailVerified: json["emailVerified"],
        kind: json["kind"],
        languages: List<dynamic>.from(json["languages"].map((x) => x)),
        governorates: List<dynamic>.from(json["governorates"].map((x) => x)),
        gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
        isVerified: json["isVerified"],
        rating: json["rating"],
        ratingsQuantity: json["ratingsQuantity"],
        tourRequests: List<dynamic>.from(json["tourRequests"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        passwordChangedAt: DateTime.parse(json["passwordChangedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "photo": photo,
        "role": role,
        "emailVerified": emailVerified,
        "kind": kind,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "governorates": List<dynamic>.from(governorates.map((x) => x)),
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "isVerified": isVerified,
        "rating": rating,
        "ratingsQuantity": ratingsQuantity,
        "tourRequests": List<dynamic>.from(tourRequests.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "passwordChangedAt": passwordChangedAt.toIso8601String(),
      };
}
