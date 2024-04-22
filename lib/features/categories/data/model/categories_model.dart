import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {
  final String? id;
  final String? name;
  final String? imageCover;

  const CategoriesModel({this.id, this.name, this.imageCover});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      imageCover: json['imageCover'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'imageCover': imageCover,
      };

  @override
  List<Object?> get props => [id, name, imageCover];
}
