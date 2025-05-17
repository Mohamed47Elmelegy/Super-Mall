import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String? postalCode;
  final bool isPrimary;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.city,
    this.postalCode,
    required this.isPrimary,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      postalCode: json['postal_code'] as String?,
      isPrimary: json['is_primary'] as bool,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'postal_code': postalCode ?? null,
      'is_primary': isPrimary,
      'deleted_at': deletedAt?.toIso8601String() ?? null,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [address];
}
