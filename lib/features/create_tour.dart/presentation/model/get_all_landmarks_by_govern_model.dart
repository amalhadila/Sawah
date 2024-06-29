class GetAllLandmarksByGovernModel {
    String status;
    int results;
    Data data;

    GetAllLandmarksByGovernModel({
        required this.status,
        required this.results,
        required this.data,
    });

    factory GetAllLandmarksByGovernModel.fromJson(Map<String, dynamic> json) => GetAllLandmarksByGovernModel(
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
        landmarks: List<Landmark>.from(json["landmarks"].map((x) => Landmark.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "landmarks": List<dynamic>.from(landmarks.map((x) => x.toJson())),
    };
}

class Landmark {
    Location location;
    String id;
    String name;
    String description;
    List<String> images;
    List<dynamic> imagesId;
    Category category;
    int visitsNumber;
    dynamic rating;
    int ratingsQuantity;
    String slug;
    int v;
    String landmarkId;

    Landmark({
        required this.location,
        required this.id,
        required this.name,
        required this.description,
        required this.images,
        required this.imagesId,
        required this.category,
        required this.visitsNumber,
        required this.rating,
        required this.ratingsQuantity,
        required this.slug,
        required this.v,
        required this.landmarkId,
    });

    factory Landmark.fromJson(Map<String, dynamic> json) => Landmark(
        location: Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        imagesId: List<dynamic>.from(json["imagesId"].map((x) => x)),
        category: Category.fromJson(json["category"]),
        visitsNumber: json["visitsNumber"],
        rating: json["rating"],
        ratingsQuantity: json["ratingsQuantity"],
        slug: json["slug"],
        v: json["__v"],
        landmarkId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "imagesId": List<dynamic>.from(imagesId.map((x) => x)),
        "category": category.toJson(),
        "visitsNumber": visitsNumber,
        "rating": rating,
        "ratingsQuantity": ratingsQuantity,
        "slug": slug,
        "__v": v,
        "id": landmarkId,
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

class Location {
    String type;
    List<double> coordinates;
    String governorate;

    Location({
        required this.type,
        required this.coordinates,
        required this.governorate,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        governorate: json["governorate"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "governorate": governorate,
    };
}
