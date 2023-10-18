import 'dart:convert';
import 'dart:typed_data';

class Images {
  Images({
    this.prodId,
    this.img,
  });

  Images.fromJson(dynamic json) {
    prodId = json['prodId'];
    if (json['img'] != null) {
      img = base64Decode(json['img']);
    }
  }
  int? prodId;
  Uint8List? img;

  Images copyWith({
    int? prodId,
    Uint8List? img,
  }) =>
      Images(
        prodId: prodId ?? this.prodId,
        img: img ?? this.img,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prodId'] = prodId;
    map['img'] = img != null ? base64Encode(img!) : null;
    return map;
  }
}
