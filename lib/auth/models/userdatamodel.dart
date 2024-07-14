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
  final List<String>? languages;
  final List<String>? governorates;
  final double? rating;
  final int? ratingsQuantity;
  final List<String>? tourRequests;
  final String? bio;
  final String? photoId;

  UserData({
    required this.emailVerified,
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.role,
    required this.interests,
    this.languages,
    this.governorates,
    this.rating,
    this.ratingsQuantity,
    this.tourRequests,
    this.bio,
    this.photoId,
  });

  factory UserData.fromJson(Map<String, dynamic> jsonData) {
    return UserData(
      emailVerified: jsonData['emailVerified'],
      id: jsonData['_id'],
      name: jsonData['name'],
      email: jsonData['email'],
      photo: jsonData['photo'],
      role: jsonData['role'],
      interests: jsonData['interests'] != null
          ? List<String>.from(jsonData['interests'])
          : [],
      languages: jsonData['languages'] != null
          ? List<String>.from(jsonData['languages'])
          : null,
      governorates: jsonData['governorates'] != null
          ? List<String>.from(jsonData['governorates'])
          : null,
      rating: jsonData['rating'] != null ? (jsonData['rating'] as num).toDouble() : null,
      ratingsQuantity: jsonData['ratingsQuantity'] != null ? jsonData['ratingsQuantity'] : null,
      tourRequests: jsonData['tourRequests'] != null
          ? List<String>.from(jsonData['tourRequests'])
          : null,
      bio: jsonData['bio'],
      photoId: jsonData['photoId'],
    );
  }
}
