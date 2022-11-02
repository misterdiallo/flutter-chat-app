import 'dart:convert';

class UserModel {
  int userid;
  String fullname;
  String alias;
  String sex;
  String email;
  String phone;
  String description;
  String picture;
  UserModel({
    required this.userid,
    required this.fullname,
    required this.alias,
    required this.sex,
    required this.email,
    required this.phone,
    required this.description,
    required this.picture,
  });

  UserModel copyWith({
    int? userid,
    String? fullname,
    String? alias,
    String? sex,
    String? email,
    String? phone,
    String? description,
    String? picture,
  }) {
    return UserModel(
      userid: userid ?? this.userid,
      fullname: fullname ?? this.fullname,
      alias: alias ?? this.alias,
      sex: sex ?? this.sex,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      description: description ?? this.description,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userid': userid});
    result.addAll({'fullname': fullname});
    result.addAll({'alias': alias});
    result.addAll({'sex': sex});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'description': description});
    result.addAll({'picture': picture});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userid: map['userid']?.toInt() ?? 0,
      fullname: map['fullname'] ?? '',
      alias: map['alias'] ?? '',
      sex: map['sex'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      description: map['description'] ?? '',
      picture: map['picture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactUserModel(userid: $userid, fullname: $fullname, alias: $alias, sex: $sex, email: $email, phone: $phone, description: $description, picture: $picture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userid == userid &&
        other.fullname == fullname &&
        other.alias == alias &&
        other.sex == sex &&
        other.email == email &&
        other.phone == phone &&
        other.description == description &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
        fullname.hashCode ^
        alias.hashCode ^
        sex.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        description.hashCode ^
        picture.hashCode;
  }
}
