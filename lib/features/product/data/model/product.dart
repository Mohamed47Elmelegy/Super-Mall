import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String code;
  final Map<String, String> name;
  final Map<String, String> category;
  final Map<String, String> brand;
  final Map<String, String> description;
  final String image;
  final List<String> gallery;
  final int quantity;
  final num price;
  final bool isActive;
  final bool isNew;
  final bool isFeatured;
  final bool isBest;
  final bool isHot;
  final String createdAt;

  const Product({
    required this.code,
    required this.name,
    required this.category,
    required this.brand,
    required this.description,
    required this.image,
    required this.gallery,
    required this.quantity,
    required this.price,
    required this.isActive,
    required this.isNew,
    required this.isFeatured,
    required this.isBest,
    required this.isHot,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'],
      name: Map<String, String>.from(json['name']),
      category: Map<String, String>.from(json['category']),
      brand: Map<String, String>.from(json['brand']),
      description: Map<String, String>.from(json['description']),
      image: json['image'],
      gallery: List<String>.from(json['gallery']),
      quantity: json['quantity'],
      price: json['price'],
      isActive: json['is_active'] == 1,
      isNew: json['is_new'] == 1,
      isFeatured: json['is_featured'] == 1,
      isBest: json['is_best'] == 1,
      isHot: json['is_hot'] == 1,
      createdAt: json['created_at'],
    );
  }

  @override
  List<Object?> get props => [code];
}
