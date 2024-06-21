class ChatRoom {
  String? id;
  List? members;
  String? lastMessage;
  String? lastMessageTime;
  String? createdAt;

  ChatRoom({
    required this.id,
    required this.createdAt,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.members,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] ?? "",
      members: json['members'] ?? [],
      lastMessage: json['last_message'] ?? "",
      lastMessageTime: json['last_message_time'] ?? "",
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'members': members,
    };
  }
}
