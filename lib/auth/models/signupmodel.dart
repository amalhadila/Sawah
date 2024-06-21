class SignUpModel {
  final String name;
  final String token;
  final String email;
  final String photo;
  final String role;

  SignUpModel(
      {required this.email,
      required this.photo,
      required this.role,
      required this.name,
      required this.token});

  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
    return SignUpModel(
      token: jsonData['token'],
      name: jsonData['data']['user']['name'],
      email: jsonData['data']['user']['email'],
      photo: jsonData['data']['user']['photo'],
      role: jsonData['data']['user']['role'],
    );
  }
}
