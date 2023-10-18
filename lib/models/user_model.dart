import 'dart:convert';
import 'dart:typed_data';

class Users {
  Users({
    this.id,
    this.name,
    this.email,
    this.password,
    this.img,
  });

  Users.fromJson(dynamic json) {
    id = int.parse(json['id']);
    name = json['name'];
    email = json['email'];
    password = json['password'];
    if (json['image'] != null) {
      img = base64Decode(json['image']);
    }
  }
  int? id;
  String? name;
  String? email;
  String? password;
  Uint8List? img;

  Users copyWith(
          {int? id,
          String? name,
          String? email,
          String? password,
          Uint8List? img}) =>
      Users(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        img: img ?? this.img,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['image'] = img != null ? base64Encode(img!) : null;
    return map;
  }
}
