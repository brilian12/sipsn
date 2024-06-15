// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    bool success;
    Pemasukan data;
    String message;

    Welcome({
        required this.success,
        required this.data,
        required this.message,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        data: Pemasukan.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Pemasukan {
    int tukar;

    Pemasukan({
        required this.tukar,
    });

    factory Pemasukan.fromJson(Map<String, dynamic> json) => Pemasukan(
        tukar: json["tukar"],
    );

    Map<String, dynamic> toJson() => {
        "tukar": tukar,
    };
}
