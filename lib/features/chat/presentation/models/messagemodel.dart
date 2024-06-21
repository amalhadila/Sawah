class Message {
  String? id;
  String? toId;
  String? fromId;
  String? msg;
  bool? read;
  DateTime? createdAt;
  String? type;
  String? imageUrl;

  Message({
    this.id,
    this.toId,
    this.fromId,
    this.msg,
    this.read,
    this.createdAt,
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
      'created_at': createdAt?.toIso8601String(),
      'type': type,
      'imageUrl': imageUrl,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      toId: json['toId'],
      fromId: json['fromId'],
      msg: json['msg'],
      read: json['read'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      type: json['type'],
      imageUrl: json['imageUrl'],
    );
  }
}
