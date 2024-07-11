class SignInModel {
  final String name;
  final String token;
  final String email;
  final String photo;
  final String role;
  final String id;

  SignInModel(
      {required this.email,
      required this.photo,
      required this.role,
      required this.name,
      required this.token,
      required this.id});

  factory SignInModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInModel(
        token: jsonData['token'],
        name: jsonData['data']['user']['name'],
        email: jsonData['data']['user']['email'],
        photo: jsonData['data']['user']['photo'],
        role: jsonData['data']['user']['role'],
        id: jsonData['data']['user']['_id']);
  }
}
