import 'package:equatable/equatable.dart';
import 'part.dart';

class History extends Equatable {
  final String role;
  final List<Part> parts;
  final String id;

  const History({
    required this.role,
    required this.parts,
    required this.id,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      role: json['role'] as String,
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => Part.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      id: json['_id'] as String,
    );
  }

  @override
  List<Object?> get props => [role, parts, id];
}
