import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable{
    final String id, first_name, last_name, username, email;

    const User({ required this.id, required this.first_name, required this.last_name,
        required this.username, required this.email });

    factory User.fromJson(dynamic json) {
        return User(
            id: json["id"], first_name: json["first_name"], last_name: json["last_name"], username: json["username"],
            email: json["email"]
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id, "first_name": first_name, "last_name": last_name, "username": username,
        "email": email
    };

    String serialize() => jsonEncode(toJson());

    @override
    List<Object?> get props => [ id, first_name, last_name, username, email ];
}