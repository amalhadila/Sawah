class GetAllLandmarksByGovernModel {
  String status;
  int results;
  Data data;

  GetAllLandmarksByGovernModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory GetAllLandmarksByGovernModel.fromJson(Map<String, dynamic> json) =>
      GetAllLandmarksByGovernModel(
        status: json["status"],
        results: json["results"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data.toJson(),
      };
}

class Data {
  List<Landmark> landmarks;

  Data({
    required this.landmarks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        landmarks: List<Landmark>.from(
            json["landmarks"].map((x) => Landmark.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "landmarks": List<dynamic>.from(landmarks.map((x) => x.toJson())),
      };
}

class Landmark {
  String id;
  String name;
  String description;
  List<String> images;
  Category category;

  Landmark({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.category,
  });

  factory Landmark.fromJson(Map<String, dynamic> json) => Landmark(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
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