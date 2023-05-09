// To parse this JSON data, do
//
//     final login = loginFromMap(jsonString);

import 'dart:convert';

Login loginFromMap(String str) => Login.fromMap(json.decode(str));

String loginToMap(Login data) => json.encode(data.toMap());

class Login {
    Login({
        this.uid,
        this.name,
        this.email,
        this.photo,
    });

    String? uid;
    String? name;
    String? email;
    String? photo;

    factory Login.fromMap(Map<String, dynamic> json) => Login(
        uid: json["UID"],
        name: json["name"],
        email: json["email"],
        photo: json["photo"],
    );

    Map<String, dynamic> toMap() => {
        "UID": uid,
        "name": name,
        "email": email,
        "photo": photo,
    };
}
