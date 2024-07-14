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
  List<Result> result;
  Gemini gemini;

  Data({
    required this.result,
    required this.gemini,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        gemini: Gemini.fromJson(json["gemini"]),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "gemini": gemini.toJson(),
      };
}

class Result {
  String? label;
 // double? score;

  Result({
     this.label,
    //required this.score,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        label: json["label"],
        //score: json["score"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
       // "score": score,
      };
}

class Gemini {
  String label;
  String description;

  Gemini({
    required this.label,
    required this.description,
  });

  factory Gemini.fromJson(Map<dynamic, dynamic> json) => Gemini(
        label: json["label"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "description": description,
      };
}
