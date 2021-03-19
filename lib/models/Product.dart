import 'dart:convert';

import 'package:intl/intl.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final formatCurrency = NumberFormat.compactCurrency(
      locale: "id", decimalDigits: 0, symbol: "Rp ");
  // Getter price for formatting
  dynamic get priceFormatted => formatCurrency.format(int.parse(price));

  final normalCurrency =
      NumberFormat.currency(locale: "id", decimalDigits: 0, symbol: "Rp");
  get normalCurrencyPriceFormatted => normalCurrency.format(int.parse(price));

  Product(
      {this.id,
      this.title,
      this.description,
      this.img,
      this.price,
      this.categoryId,
      this.userId,
      this.categoryName,
      this.rating});

  int id;
  String title;
  String description;
  String img;
  String price;
  int categoryId;
  int userId;
  String categoryName;
  double rating;

  Product copyWith({
    int id,
    String title,
    String description,
    String img,
    String price,
    int categoryId,
    int userId,
    String categoryName,
    double rating,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        img: img ?? this.img,
        price: price ?? this.price,
        categoryId: categoryId ?? this.categoryId,
        userId: userId ?? this.userId,
        categoryName: categoryName ?? this.categoryName,
        rating: rating.toDouble() ?? this.rating.toDouble(),
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        img: json["img"],
        price: json["price"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        categoryName: json["category_name"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "img": img,
        "price": price,
        "category_id": categoryId,
        "user_id": userId,
        "category_name": categoryName,
        "rating": rating.toDouble(),
      };
}
