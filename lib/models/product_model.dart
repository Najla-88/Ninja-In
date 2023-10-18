import 'package:ninjain/models/image_model.dart';

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.cateId,
    this.images,
  });

  Product.fromJson(dynamic json) {
    id = int.parse(json['id']);
    name = json['name'];
    description = json['description'];
    price = json['price'].toString();
    cateId = int.parse(json['cate_id']);
    images = json['img'] != null ? [json['img']] : null;
  }
  int? id;
  String? name;
  String? description;
  String? price;
  int? cateId;
  List<Images>? images;

  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    int? cateId,
    List<Images>? images,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        cateId: cateId ?? this.cateId,
        images: images ?? this.images,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['price'] = double.parse(price ?? '');
    map['cate_id'] = cateId;
    map['img'] = images;
    return map;
  }
}
