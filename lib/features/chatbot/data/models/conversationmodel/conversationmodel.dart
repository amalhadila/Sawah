import 'package:equatable/equatable.dart';
import 'history.dart';

class Conversationmodel extends Equatable {
  final String id;
  final String user;
  final List<History> history;
  final int v;

  const Conversationmodel({
    required this.id,
    required this.user,
    required this.history,
    required this.v,
  });

  factory Conversationmodel.fromJson(Map<String, dynamic> json) {
    return Conversationmodel(
      id: json['_id'] as String,
      user: json['user'] as String,
      history: (json['history'] as List<dynamic>?)
              ?.map((e) => History.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      v: json['__v'] as int,
    );
  }

  @override
  List<Object?> get props => [id, user, history, v];
}
