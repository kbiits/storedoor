// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

import 'package:storedoor/models/Product.dart';

List<CartItem> cartFromJson(String str) => List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartToJson(List<CartItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
    CartItem({
        this.product,
        this.count,
    });

    Product product;
    int count;

    CartItem copyWith({
        Product product,
        int count,
    }) => 
        CartItem(
            product: product ?? this.product,
            count: count ?? this.count,
        );

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json["product"]),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "count": count,
    };
}

// class Product {
//     Product({
//         this.id,
//         this.title,
//         this.description,
//         this.img,
//         this.price,
//         this.categoryId,
//         this.userId,
//     });

//     int id;
//     String title;
//     String description;
//     String img;
//     String price;
//     String categoryId;
//     int userId;

//     Product copyWith({
//         int id,
//         String title,
//         String description,
//         String img,
//         String price,
//         String categoryId,
//         int userId,
//     }) => 
//         Product(
//             id: id ?? this.id,
//             title: title ?? this.title,
//             description: description ?? this.description,
//             img: img ?? this.img,
//             price: price ?? this.price,
//             categoryId: categoryId ?? this.categoryId,
//             userId: userId ?? this.userId,
//         );

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         title: json["title"],
//         description: json["description"],
//         img: json["img"],
//         price: json["price"],
//         categoryId: json["category_id"],
//         userId: json["user_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "img": img,
//         "price": price,
//         "category_id": categoryId,
//         "user_id": userId,
//     };
// }
