// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    bool success;
    Data data;
    String message;

    Welcome({
        required this.success,
        required this.data,
        required this.message,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };
}

class Data {
    Tukar tukar;

    Data({
        required this.tukar,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        tukar: Tukar.fromJson(json["tukar"]),
    );

    Map<String, dynamic> toJson() => {
        "tukar": tukar.toJson(),
    };
}

class Tukar {
    int id;
    int nasabahId;
    int total;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Tukar({
        required this.id,
        required this.nasabahId,
        required this.total,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Tukar.fromJson(Map<String, dynamic> json) => Tukar(
        id: json["id"],
        nasabahId: json["nasabah_id"],
        total: json["total"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nasabah_id": nasabahId,
        "total": total,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
