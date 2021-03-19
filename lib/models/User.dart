import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({this.email, this.username, this.id, this.token});

  String email;
  String username;
  int id;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        id: json["id"],
        token: json["token"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "token": token,
        "username": username,
      };
}
