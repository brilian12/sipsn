

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    bool success;
    String message;
    Data data;

    Welcome({
        required this.success,
        required this.message,
        required this.data,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
    Nasabah nasabah;
    // Petugas petugas;

    Data({
        required this.id,
        required this.username,
        required this.status,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
        required this.token,
        required this.tokenType,
        required this.nasabah,
        // required this.petugas,
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
        nasabah: Nasabah.fromJson(json["nasabah"]),
        // petugas: Petugas.fromJson(json["petugas"]),
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
        "nasabah": nasabah.toJson(),
        // "petugas": petugas.toJson(),
    };
}

class Nasabah {
    int id;
    int userId;
    String name;
    String alamat;
    String noHp;
    String kodePengguna;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Nasabah({
        required this.id,
        required this.userId,
        required this.name,
        required this.alamat,
        required this.noHp,
        required this.kodePengguna,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Nasabah.fromJson(Map<String, dynamic> json) => Nasabah(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        kodePengguna: json["kode_pengguna"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "alamat": alamat,
        "no_hp": noHp,
        "kode_pengguna": kodePengguna,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

// class Petugas {
//     int id;
//     int userId;
//     int adminId;
//     String name;
//     String noHp;
//     String alamat;
//     DateTime createdAt;
//     DateTime updatedAt;
//     dynamic deletedAt;

//     Petugas({
//         required this.id,
//         required this.userId,
//         required this.adminId,
//         required this.name,
//         required this.noHp,
//         required this.alamat,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.deletedAt,
//     });

//     factory Petugas.fromJson(Map<String, dynamic> json) => Petugas(
//         id: json["id"],
//         userId: json["user_id"],
//         adminId: json["admin_id"],
//         name: json["name"],
//         noHp: json["no_hp"],
//         alamat: json["alamat"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         deletedAt: json["deleted_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "admin_id": adminId,
//         "name": name,
//         "no_hp": noHp,
//         "alamat": alamat,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "deleted_at": deletedAt,
//     };
// }