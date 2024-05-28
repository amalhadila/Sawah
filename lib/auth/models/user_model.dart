
class userModel {
  final String status;
  final String token;
  final UserData data;

  userModel({
    required this.status,
    required this.token,
    required this.data,
  });

  factory userModel.fromJson(Map<String, dynamic> json) {
    return userModel(
      status: json['status'],
      token: json['token'],
      data: UserData.fromJson(json['data']['user']),
    );
  }
}

class UserData {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String role;
  final List<String> interests;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.interests,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      role: json['role'],
      interests: List<String>.from(json['interests']),
    );
  }
}
