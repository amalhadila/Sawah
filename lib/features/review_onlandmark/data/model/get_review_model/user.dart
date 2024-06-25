class User {
  String? id;
  String? name;
  String? photo;
  String? kind;

  User({this.id, this.name, this.photo, this.kind});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        photo: json['photo'] as String?,
        kind: json['kind'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'photo': photo,
        'kind': kind,
      };
}
