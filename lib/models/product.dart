import 'dart:convert';

import 'package:flutter_nodejs/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String? id;
  final String name;
  final String description;
  final double quantity;
  final double price;
  final String category;
  final List<String> images;
  final List<Rating>? rating;

  Product(
      {this.id,
      required this.name,
      required this.description,
      required this.quantity,
      required this.price,
      required this.category,
      required this.images,
      this.rating});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'category': category,
      'images': images,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as double,
      price: map['price'] as double,
      category: map['category'] as String,
      images: List<String>.from(
        (map['images'] as List<String>),
      ),
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
