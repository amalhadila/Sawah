class GetAllGovernsModel {
    String status;
    int results;
    Data data;

    GetAllGovernsModel({
        required this.status,
        required this.results,
        required this.data,
    });

    factory GetAllGovernsModel.fromJson(Map<String, dynamic> json) => GetAllGovernsModel(
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
    List<String> governorates;

    Data({
        required this.governorates,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        governorates: List<String>.from(json["governorates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "governorates": List<dynamic>.from(governorates.map((x) => x)),
    };
}
