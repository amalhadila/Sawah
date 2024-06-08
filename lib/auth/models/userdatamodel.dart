class userdatamodel {
  final String status;
  final UserData data;

  userdatamodel({
    required this.status,
    required this.data,
  });

  factory userdatamodel.fromJson(Map<String, dynamic> jsonData) {
    return userdatamodel(
      status: jsonData['status'],
      data: UserData.fromJson(jsonData['data']['doc']),
    );
  }
}

class UserData {
  final bool emailVerified;
  final String id;
  final String name;
  final String email;
  final String photo;
  final String role;
  final List<String> interests;

  UserData({
    required this.emailVerified,
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.interests,
  });

  factory UserData.fromJson(Map<String, dynamic> jsonData) {
    return UserData(
      emailVerified: jsonData['emailVerified'],
      id: jsonData['_id'],
      name: jsonData['name'],
      email: jsonData['email'],
      photo: jsonData['photo'],
      role: jsonData['role'],
      interests: List<String>.from(jsonData['interests']),
    );
  }
}
