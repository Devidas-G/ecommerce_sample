// Model for the entire cart/order
class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<ProductInfo> productInfo;
  final int version;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.productInfo,
    required this.version,
  });

  // Factory method to create a Cart object from JSON
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int,
      userId: json['userId'] as int,
      date: DateTime.parse(json['date'] as String),
      productInfo:
          (json['products'] as List<dynamic>)
              .map(
                (productJson) =>
                    ProductInfo.fromJson(productJson as Map<String, dynamic>),
              )
              .toList(),
      version: json['__v'] as int,
    );
  }

  // Method to convert a Cart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'products': productInfo.map((product) => product.toJson()).toList(),
      '__v': version,
    };
  }
}

// Model for each product in the cart
class ProductInfo {
  final int productId;
  final int quantity;

  ProductInfo({required this.productId, required this.quantity});

  // Factory method to create a Product object from JSON
  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
    );
  }

  // Method to convert a Product object to JSON
  Map<String, dynamic> toJson() {
    return {'productId': productId, 'quantity': quantity};
  }
}
