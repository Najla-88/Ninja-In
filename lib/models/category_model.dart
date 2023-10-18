class Category {
  Category({
    this.id,
    this.name,
  });

  Category.fromJson(dynamic json) {
    id = int.parse(json['id']);
    name = json['name'];
  }
  int? id;
  String? name;

  Category copyWith({
    int? id,
    String? name,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
