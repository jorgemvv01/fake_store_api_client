import 'package:equatable/equatable.dart';

class ProductRequest extends Equatable {
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;

  const ProductRequest({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
    };
  }
  
  @override
  List<Object> get props => [title, price, description, image, category];

  ProductRequest copyWith({
    String? title,
    double? price,
    String? description,
    String? image,
    String? category,
  }) {
    return ProductRequest(
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      category: category ?? this.category,
    );
  }
}
