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
    List<Jadwal> jadwal;
    List<Lokasi> lokasi;

    Data({
        required this.jadwal,
        required this.lokasi,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        jadwal: List<Jadwal>.from(json["jadwal"].map((x) => Jadwal.fromJson(x))),
        lokasi: List<Lokasi>.from(json["lokasi"].map((x) => Lokasi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "jadwal": List<dynamic>.from(jadwal.map((x) => x.toJson())),
        "lokasi": List<dynamic>.from(lokasi.map((x) => x.toJson())),
    };
}

class Jadwal {
    int id;
    int jadwalTugasId;
    int petugasId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    JadwalTugas jadwalTugas;

    Jadwal({
        required this.id,
        required this.jadwalTugasId,
        required this.petugasId,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.jadwalTugas,
    });

    factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        id: json["id"],
        jadwalTugasId: json["jadwal_tugas_id"],
        petugasId: json["petugas_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        jadwalTugas: JadwalTugas.fromJson(json["jadwal_tugas"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jadwal_tugas_id": jadwalTugasId,
        "petugas_id": petugasId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "jadwal_tugas": jadwalTugas.toJson(),
    };
}

class JadwalTugas {
    int id;
    int lokasiId;
    int adminId;
    DateTime mulaiPenjemputan;
    DateTime selesaiPenjemputan;
    String keterangan;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    JadwalTugas({
        required this.id,
        required this.lokasiId,
        required this.adminId,
        required this.mulaiPenjemputan,
        required this.selesaiPenjemputan,
        required this.keterangan,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory JadwalTugas.fromJson(Map<String, dynamic> json) => JadwalTugas(
        id: json["id"],
        lokasiId: json["lokasi_id"],
        adminId: json["admin_id"],
        mulaiPenjemputan: DateTime.parse(json["mulai_penjemputan"]),
        selesaiPenjemputan: DateTime.parse(json["selesai_penjemputan"]),
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi_id": lokasiId,
        "admin_id": adminId,
        "mulai_penjemputan": mulaiPenjemputan.toIso8601String(),
        "selesai_penjemputan": selesaiPenjemputan.toIso8601String(),
        "keterangan": keterangan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class Lokasi {
    int id;
    int adminId;
    String tempat;
    String koordinat;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Lokasi({
        required this.id,
        required this.adminId,
        required this.tempat,
        required this.koordinat,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        id: json["id"],
        adminId: json["admin_id"],
        tempat: json["tempat"],
        koordinat: json["koordinat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "tempat": tempat,
        "koordinat": koordinat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
