// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class Welcome {
//     bool success;
//     Riwayat data;
//     String message;

//     Welcome({
//         required this.success,
//         required this.data,
//         required this.message,
//     });

//     factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         success: json["success"],
//         data: Riwayat.fromJson(json["data"].map((x) => Riwayat.fromJson(x))),
//         message: json["message"],
//     );


//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data.toJson(),
//         "message": message,
//     };
// }

class Riwayat {
    int id;
    // int sampah_id;
    int admin_id;
    DateTime tanggal;
    String status;
    String instansi;
    // int kurang_poin;

    Riwayat({
        required this.id,
        // required this.sampah_id,
        required this.admin_id,
        required this.tanggal,
        required this.status,
        required this.instansi,
        // required this.kurang_poin,
    });

    factory Riwayat.fromJson(Map<String, dynamic> json) => Riwayat(
        id: json["id"],
        // sampah_id: json["sampah_id"],
        admin_id: json["admin_id"],
        tanggal: DateTime.parse(json["tanggal"]),
        status: json["status"],
        instansi: json["instansi"],
        // kurang_poin: json["kurang_poin"]
    );

    

    Map<String, dynamic> toJson() => {
        "id": id,
        // "sampah_id": sampah_id,
        "admin_id": admin_id,
        "tanggal": tanggal.toIso8601String(),
        "status": status,
        "instansi": instansi,
        // "kurang_poin": kurang_poin
    };
    
}
