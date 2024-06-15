// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    bool success;
    Kontribusi data;
    String message;

    Welcome({
        required this.success,
        required this.data,
        required this.message,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        data: Kontribusi.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Kontribusi {
    int tukar;

    Kontribusi({
        required this.tukar,
    });

    factory Kontribusi.fromJson(Map<String, dynamic> json) => Kontribusi(
        tukar: json["tukar"],
    );

    Map<String, dynamic> toJson() => {
        "tukar": tukar,
    };
}
