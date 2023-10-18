class ProductFeature {
  ProductFeature({
    this.prodId,
    this.featId,
  });

  ProductFeature.fromJson(dynamic json) {
    prodId = json['product_id'];
    featId = json['feature_id'];
  }
  int? prodId;
  int? featId;

  ProductFeature copyWith({
    int? featId,
    int? prodId,
  }) =>
      ProductFeature(
        prodId: prodId ?? this.prodId,
        featId: featId ?? this.featId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = prodId;
    map['feature_id'] = featId;
    return map;
  }
}
