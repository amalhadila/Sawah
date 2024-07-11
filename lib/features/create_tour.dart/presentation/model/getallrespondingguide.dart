class RespondingGuide {
  Guide? guide;
  int? price;
  String? id;

  RespondingGuide({
    this.guide,
    this.price,
    this.id,
  });

  factory RespondingGuide.fromJson(Map<String, dynamic> json) {
    return RespondingGuide(
      guide: json["guide"] != null
          ? Guide.fromJson(json["guide"] as Map<String, dynamic>)
          : null,
      price: json["price"] as int?,
      id: json["_id"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "guide": guide?.toJson(),
        "price": price,
        "_id": id,
      };
}

class Guide {
  String? id;
  String? name;
  String? photo;
  String? kind;
  double? rating;
  int? ratingsQuantity;

  Guide({
    this.id,
    this.name,
    this.photo,
    this.kind,
    this.rating,
    this.ratingsQuantity,
  });

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
