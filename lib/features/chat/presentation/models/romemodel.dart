class ChatRoom {
  String? id;
   String? name;
  String? pushtoken;
  String? userid;
  List<String>? members;
  String? lastMessage;
  DateTime? lastMessageTime;
  DateTime? createdAt;

  ChatRoom({
    required this.id,
    required this.name,
    required this.userid,
   //  required this.pushtoken,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.createdAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      userid: json['userid'] ?? "",
      //pushtoken: json['pushtoken'] ?? "",
      members: List<String>.from(json['members'] ?? []),
      lastMessage: json['last_message'] ?? "",
      lastMessageTime: json['last_message_time'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(json['last_message_time'])) : null,
      createdAt: json['created_at'] != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(json['created_at'])) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name':name,
      'userid': userid,
     // 'pushtoken':pushtoken,
      'members': members,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime?.millisecondsSinceEpoch.toString(),
      'created_at': createdAt?.millisecondsSinceEpoch.toString(),
    };
  }
}
