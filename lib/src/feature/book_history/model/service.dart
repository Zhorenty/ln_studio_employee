import 'package:flutter/foundation.dart';

///
@immutable
final class ServiceModel {
  const ServiceModel({
    required this.id,
    required this.categoryId,
    required this.photo,
    required this.name,
    required this.price,
    required this.description,
    this.priceWithDiscount,
    this.duration,
  });

  ///
  final int id;

  ///
  final int categoryId;

  ///
  final String photo;

  ///
  final String name;

  ///
  final int price;

  ///
  final int? priceWithDiscount;

  ///
  final String description;

  ///
  final int? duration;

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      categoryId: json['category_id'],
      photo: json['photo'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      priceWithDiscount: json['price_with_discount'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'photo': photo,
      'name': name,
      'price': price,
      'description': description,
      'price_with_discount': priceWithDiscount,
      'duration': duration,
    };
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModel &&
          runtimeType == other.runtimeType &&
          id == other.id;
}
