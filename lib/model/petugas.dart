import 'dart:convert';


import 'dart:convert';

Will willFromJson(String str) => Will.fromJson(json.decode(str));

String willToJson(Will data) => json.encode(data.toJson());

class Will {
    bool success;
    String message;
    Data data;

    Will({
        required this.success,
        required this.message,
        required this.data,
    });

    factory Will.fromJson(Map<String, dynamic> json) => Will(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String username;
    String status;
    String role;
    DateTime createdAt;
    DateTime updatedAt;
    String token;
    String tokenType;
    Petugas petugas;

    Data({
        required this.id,
        required this.username,
        required this.status,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
        required this.token,
        required this.tokenType,
        required this.petugas,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        status: json["status"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
        tokenType: json["token_type"],
        petugas: Petugas.fromJson(json["petugas"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "status": status,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
        "token_type": tokenType,
        "petugas": petugas.toJson(),
    };
}

class Petugas {
    int id;
    int userId;
    int adminId;
    String name;
    String noHp;
    String alamat;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Petugas({
        required this.id,
        required this.userId,
        required this.adminId,
        required this.name,
        required this.noHp,
        required this.alamat,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Petugas.fromJson(Map<String, dynamic> json) => Petugas(
        id: json["id"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        name: json["name"],
        noHp: json["no_hp"],
        alamat: json["alamat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "admin_id": adminId,
        "name": name,
        "no_hp": noHp,
        "alamat": alamat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}