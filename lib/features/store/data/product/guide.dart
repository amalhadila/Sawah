import 'package:equatable/equatable.dart';

class Guide extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? photo;
  final String? kind;

  const Guide({this.id, this.name, this.email, this.photo, this.kind});

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      photo: json['photo'] as String?,
      kind: json['kind'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'kind': kind,
    };
  }

  @override
  List<Object?> get props => [id, name, email, photo, kind];
}
