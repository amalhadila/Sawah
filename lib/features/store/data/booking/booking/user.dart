import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? kind;

  const User({this.id, this.email, this.kind});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        email: json['email'] as String?,
        kind: json['kind'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'email': email,
        'kind': kind,
      };

  @override
  List<Object?> get props => [id, email, kind];
}
