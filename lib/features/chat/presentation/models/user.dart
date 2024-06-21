class User {
  String? id;
  String? pushtoken;  

  User({
    required this.id,
      this.pushtoken,
   
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? "",
      pushtoken: json['pushtoken'] ?? "",
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,     
      'pushtoken':pushtoken,
      };
  }
}
