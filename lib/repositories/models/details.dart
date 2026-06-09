import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

class LoginDetail extends Equatable{
    final String email, password;
    final bool auto;

    const LoginDetail({required this.email, required this.password, this.auto = false} );
    factory LoginDetail.fromJson(dynamic json){
        return LoginDetail( auto: json["auto"], email: json["email"], password: json["password"]);
    }

    Map<String, dynamic> toJson() => { "email": email, "password": password, "auto": auto };

    String serialize() => json.encode(toJson());

    @override
    List<Object?> get props => [ auto, email, password ];
}
