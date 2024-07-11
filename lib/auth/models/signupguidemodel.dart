class SignUpGuideModel {
  final String name;
  final String token;
  final String email;
  final String photo;
  final String role;

  SignUpGuideModel({
    required this.name,
    required this.token,
    required this.email,
    required this.photo,
    required this.role,
  });

  factory SignUpGuideModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpGuideModel(
      name: jsonData['data']['user']['name'],
      token: jsonData['token'],
      email: jsonData['data']['user']['email'],
      photo: jsonData['data']['user']['photo'],
      role: jsonData['data']['user']['role'],
    );
  }
}
