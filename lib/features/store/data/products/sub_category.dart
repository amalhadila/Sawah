import 'package:equatable/equatable.dart';

class SubCategory extends Equatable {
  final String? id;
  final String? name;

  const SubCategory({this.id, this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['_id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];
}
