class LandMarkDetectionModel {
  String status;
  Data data;

  LandMarkDetectionModel({
    required this.status,
    required this.data,
  });

  factory LandMarkDetectionModel.fromJson(Map<String, dynamic> json) =>
      LandMarkDetectionModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Gemini gemini;

  Data({
    required this.gemini,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gemini: Gemini.fromJson(json["gemini"]),
      );

  Map<String, dynamic> toJson() => {
        "gemini": gemini.toJson(),
      };
}

class Gemini {
  String label;
  String description;

  Gemini({
    required this.label,
    required this.description,
  });

  factory Gemini.fromJson(Map<String, dynamic> json) => Gemini(
        label: json["label"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "description": description,
      };
}
