import 'package:equatable/equatable.dart';

class Cart extends Equatable {
    final int id;
    final int userId;
    final DateTime date;
    final List<Product> products;

    const Cart({
        required this.id,
        required this.userId,
        required this.date,
        required this.products,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    factory Cart.fromUpdateJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: const[]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };

    @override
    List<Object?> get props => [id, userId, date, products];
}

class Product extends Equatable{
    final int productId;
    final int quantity;

    const Product({
        required this.productId,
        required this.quantity,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
    };

    @override
    List<Object?> get props => [productId, quantity];
}
