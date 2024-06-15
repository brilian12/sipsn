import 'dart:convert';


GetProfile getProfileFromJson(String str) => GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
    bool success;
    List<Datum> data;
    String message;

    GetProfile({
        required this.success,
        required this.data,
        required this.message,
    });

    factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    int id;
    int user_id;
    String name;
    String no_hp;
    String alamat;
    DateTime createdAt;
    DateTime updatedAt;
    String username;
    

    Datum({
        required this.id,
        required this.user_id,
        required this.name,
        required this.no_hp,
        required this.alamat,
        required this.createdAt,
        required this.updatedAt,
        required this.username,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        user_id: json["user_id"],
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
        "name": name,
        "no_hp": no_hp,
        "alamat": alamat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "username": username
    };
}