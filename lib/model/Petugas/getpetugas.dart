import 'dart:convert';


GetPetugas getProfileFromJson(String str) => GetPetugas.fromJson(json.decode(str));

String getProfileToJson(GetPetugas data) => json.encode(data.toJson());

class GetPetugas {
    bool success;
    List<Petugass> data;
    String message;

    GetPetugas({
        required this.success,
        required this.data,
        required this.message,
    });

    factory GetPetugas.fromJson(Map<String, dynamic> json) => GetPetugas(
        success: json["success"],
        data: List<Petugass>.from(json["data"].map((x) => Petugass.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Petugass {
    int id;
    int user_id;
    int admin_id;
    String name;
    String no_hp;
    String alamat;
    DateTime createdAt;
    DateTime updatedAt;
    String username;
    

    Petugass({
        required this.id,
        required this.user_id,
        required this.admin_id,
        required this.name,
        required this.no_hp,
        required this.alamat,
        required this.createdAt,
        required this.updatedAt,
        required this.username,
    });

    factory Petugass.fromJson(Map<String, dynamic> json) => Petugass(
        id: json["id"],
        user_id: json["user_id"],
        admin_id: json["admin_id"],
        name: json["name"],
        no_hp: json["no_hp"],
        alamat: json["alamat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        username: json["user"]["username"]
    );

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "admin_id": admin_id,
        "name": name,
        "no_hp": no_hp,
        "alamat": alamat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "username": username
    };
}