


class Riwayatp {
    int id;
    int point_id;
    int admin_id;
    int nasabah_id;
    DateTime tanggal;
    String status;
    String instansi;
    int kurang_poin;

    Riwayatp({
        required this.id,
        required this.point_id,
        required this.admin_id,
        required this.nasabah_id,
        required this.tanggal,
        required this.status,
        required this.instansi,
        required this.kurang_poin
    });

    factory Riwayatp.fromJson(Map<String, dynamic> json) => Riwayatp(
        id: json["id"],
        point_id: json["point_id"],
        admin_id: json["admin_id"],
        nasabah_id: json["nasabah_id"],
        tanggal: DateTime.parse(json["tanggal"]),
        status: json["status"],
        instansi: json["instansi"],
        kurang_poin: json["kurang_poin"],
    );

    

    Map<String, dynamic> toJson() => {
        "id": id,
        "point_id": point_id,
        "admin_id": admin_id,
        "nasabah_id": nasabah_id,
        "tanggal": tanggal.toIso8601String(),
        "status": status,
        "instansi": instansi,
        "kurang_poin": kurang_poin,
        // "tambah_poin": tambah_poin
    };
    
}