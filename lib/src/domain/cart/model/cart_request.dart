import 'package:equatable/equatable.dart';
import 'package:fake_store_api_client/src/domain/product/model/product.dart';

class CartRequest extends Equatable {
    final int userId;
    final DateTime date;
    final List<Product> products;

    const CartRequest({
        required this.userId,
        required this.date,
        required this.products,
    });

    factory CartRequest.fromJson(Map<String, dynamic> json) => CartRequest(
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };

    @override
    List<Object?> get props => [userId, date, products];
}