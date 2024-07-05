class Kategori {
    int id;
    int adminId;
    String gambar;
    String jenisSampah;
    int poinSampah;
    int beratSampah;
    DateTime createdAt;
    DateTime updatedAt;
    // dynamic deletedAt;

    Kategori({
        required this.id,
        required this.adminId,
        required this.gambar,
        required this.jenisSampah,
        required this.poinSampah,
        required this.beratSampah,
        required this.createdAt,
        required this.updatedAt,
        // required this.deletedAt,
    });

    factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        adminId: json["admin_id"],
        gambar: json["gambar"],
        jenisSampah: json["jenis_sampah"],
        poinSampah: json["poin_sampah"],
        beratSampah: json["berat_sampah"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        // deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "gambar": gambar,
        "jenis_sampah": jenisSampah,
        "poin_sampah": poinSampah,
        "berat_sampah": beratSampah,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        // "deleted_at": deletedAt,
    };
}