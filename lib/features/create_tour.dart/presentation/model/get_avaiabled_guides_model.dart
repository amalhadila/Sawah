class GetAvailableGuidesModel {
  String? id;
  String? name;
  String? photo;
  String? kind;
  dynamic rating;
  int? ratingsQuantity;

  GetAvailableGuidesModel({this.id, this.name, this.photo, this.kind, this.rating, this.ratingsQuantity});

  factory GetAvailableGuidesModel.fromJson(Map<String, dynamic> json) {
    return GetAvailableGuidesModel(
      id: json['_id'],
      name: json['name'],
      photo: json['photo'],
      kind: json['kind'],
      rating: json['rating'],
      ratingsQuantity: json['ratingsQuantity'],
    );
  }
}