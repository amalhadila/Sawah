class userModel {
  final String status;
  final String token;
  final UserData data;

  userModel({
    required this.status,
    required this.token,
    required this.data,
  });

  factory userModel.fromJson(Map<String, dynamic> jsonData) {
    return userModel(
      status: jsonData['status'],
      token: jsonData['token'],
      data: UserData.fromjsonData(jsonData['data']['user']),
    );
  }
}

class UserData {
  final String id;
  final String ?name;
  final String ?email;
  final String? photo;
  final String ?role;
  final List<String> interests;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.interests,
  });

  factory UserData.fromjsonData(Map<String, dynamic> jsonData) {
    return UserData(
      id: jsonData['_id'],
      name: jsonData['name'],
      email: jsonData['email'],
      photo: jsonData['photo'],
      role: jsonData['role'],
      interests: List<String>.from(jsonData['interests']),
    );
  }
}
