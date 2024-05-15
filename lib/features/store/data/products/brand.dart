import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String? id;
  final String? name;

  const Brand({this.id, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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
