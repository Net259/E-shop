import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.address,
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  String? image;
  String? address;
  String name;
  String email;
  String phone;
  String id;
  String password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        address: json["address"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "address": address,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      };

  UserModel copyWith({
    String? name,
    String? address,
    String? phone,
    image,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        address: address ?? this.address,
        email: email,
        phone: phone ?? this.phone,
        password: password,
        image: image ?? this.image,
      );
}
