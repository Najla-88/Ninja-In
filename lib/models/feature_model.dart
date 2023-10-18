import 'dart:convert';
import 'dart:typed_data';

class Features {
  Features({
    this.id,
    this.name,
    this.image,
    this.cateId,
  });

  Features.fromJson(dynamic json) {
    id = int.parse(json['id']);
    name = json['name'];
    if (json['image'] != null) {
      image = base64Decode(json['image']);
    }
    cateId = int.parse(json['cate_id']);
  }
  int? id;
  String? name;
  Uint8List? image;
  int? cateId;

  Features copyWith({
    int? id,
    String? name,
    Uint8List? img,
    int? cateId,
  }) =>
      Features(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        cateId: cateId ?? this.cateId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image != null ? base64Encode(image!) : null;
    map['cate_id'] = cateId;
    return map;
  }
}
