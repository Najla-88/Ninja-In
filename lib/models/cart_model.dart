class Cart {
  Cart({
    this.id,
    this.prod_id,
    this.order_id,
    this.user_id,
    this.quantity,
    this.price,
  });

  Cart.fromJson(dynamic json) {
    id = int.parse(json['id']);
    prod_id = int.parse(json['prod_id']);
    order_id = int.parse(json['order_id']);
    user_id = int.parse(json['user_id']);
    quantity = int.parse(json['quantity']);
    price = double.parse(json['price']);
  }
  int? id;
  int? prod_id;
  int? order_id;
  int? user_id;
  int? quantity;
  double? price;

  Cart copyWith({
    int? id,
    int? prod_id,
    int? order_id,
    int? user_id,
    int? quantity,
    double? price,
  }) =>
      Cart(
        id: id ?? this.id,
        prod_id: prod_id ?? this.prod_id,
        order_id: order_id ?? this.order_id,
        user_id: user_id ?? this.user_id,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['prod_id'] = prod_id;
    map['order_id'] = order_id;
    map['user_id'] = user_id;
    map['quantity'] = quantity;
    map['price'] = price;
    return map;
  }
}
