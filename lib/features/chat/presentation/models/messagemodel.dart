import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? id;
  String? toId;
  String? fromId;
  String? msg;
  bool? read;
  final dynamic createdAt; // Can be either DateTime or FieldValue
  String? type;
  String? imageUrl;

  Message({
    this.id,
    this.toId,
    this.fromId,
    this.msg,
    this.read,
    required this.createdAt,
    this.type,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'toId': toId,
      'fromId': fromId,
      'msg': msg,
      'read': read,
      'created_at': createdAt is DateTime ? Timestamp.fromDate(createdAt) : createdAt,
      'type': type,
      'imageUrl': imageUrl,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    dynamic createdAt = json['created_at'];
    // Check if createdAt is a Timestamp (indicating it was stored as a DateTime)
    if (createdAt is Timestamp) {
      createdAt = (createdAt as Timestamp).toDate(); // Convert Timestamp to DateTime
    }
    return Message(
      id: json['id'],
      toId: json['toId'],
      fromId: json['fromId'],
      msg: json['msg'],
      read: json['read'],
      createdAt: createdAt,
      type: json['type'],
      imageUrl: json['imageUrl'],
    );
  }
}
