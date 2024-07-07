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
    double tukar;
    int poin;

    Kontribusi({
        required this.tukar,
        required this.poin
    });

    factory Kontribusi.fromJson(Map<String, dynamic> json) => Kontribusi(
        tukar: json['tukar']?.toDouble() ?? 0.0,  // Handle potential null values
      poin: json['poin'] ?? 0,  // Assuming `poin` is an integer
    );

    Map<String, dynamic> toJson() => {
        "tukar": tukar,
    };
}
